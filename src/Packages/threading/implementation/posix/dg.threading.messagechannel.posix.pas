//------------------------------------------------------------------------------
// This file is part of the DarkGlass game engine project.
// More information can be found here: http://chapmanworld.com/darkglass
//
// DarkGlass is licensed under the MIT License:
//
// Copyright 2018 Craig Chapman
//
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the “Software”),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
// DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
// OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
// USE OR OTHER DEALINGS IN THE SOFTWARE.
//------------------------------------------------------------------------------
unit dg.threading.messagechannel.posix;

interface
uses
  system.syncobjs,
  Posix.SysTypes,
  dg.threading.types,
  dg.threading.messagepipe,
  dg.threading.messagechannel,
  dg.threading.messagechannel.common;


type
  TMessageChannel = class( TCommonMessageChannel, IMessageChannel )
  private
    fMessagesWaiting: boolean;
    fMessagesWaitingSpin: pthread_mutex_t;
    fMessagesWaitingSignal: pthread_cond_t;
    fResponseSpin: pthread_mutex_t;
    fResponseSignal: pthread_cond_t;
    procedure LockResponse;
    procedure UnlockResponse;
  protected
    function Pull( var aMessage: TMessage; WaitFor: boolean = False ): boolean; override;
    procedure SignalHandled; override;

  protected //- IMessageChannel -//
    function ProcessMessages( MessageHandler: TMessageHandlerProc; WaitFor: Boolean = False ): boolean; override;
    function Push( Pipe: IMessagePipe; MessageValue: uint32; ParamA: NativeUInt; ParamB: NativeUInt; WaitFor: Boolean = False ): TMessageResponse;

  public
    constructor Create( aName: string ); reintroduce;
    destructor Destroy; override;
  end;


implementation
uses
  Posix.pthread,
  sysutils;

{ TMessageChannel }

constructor TMessageChannel.Create( aName: string );
begin
  inherited Create( aName );
  fMessagesWaiting := False;
  if pthread_cond_init(fMessagesWaitingSignal,nil)<>0 then begin
    raise
      Exception.Create('Failed to initialize condition variable.');
    exit;
  end;
  if pthread_mutex_init(fMessagesWaitingSpin, nil)<>0 then begin
    raise
      Exception.Create('Failed to initialize mutex.');
    exit;
  end;
  if pthread_cond_init(fResponseSignal,nil)<>0 then begin
    raise
      Exception.Create('Failed to initialize condition variable.');
    exit;
  end;
  if pthread_mutex_init(fResponseSpin, nil)<>0 then begin
    raise
      Exception.Create('Failed to initialize mutex.');
    exit;
  end;
end;

destructor TMessageChannel.Destroy;
begin
  pthread_mutex_destroy(fMessagesWaitingSpin);
  pthread_cond_destroy(fMessagesWaitingSignal);
  pthread_mutex_destroy(fResponseSpin);
  pthread_cond_destroy(fResponseSignal);
  inherited Destroy;
end;

function TMessageChannel.ProcessMessages(MessageHandler: TMessageHandlerProc; WaitFor: Boolean): boolean;
begin
  Result := inherited ProcessMessages(MessageHandler,WaitFor);
end;

function TMessageChannel.Pull(var aMessage: TMessage; WaitFor: boolean): boolean;
begin
  if not WaitFor then begin
    Result := inherited Pull(aMessage,FALSE);
    exit;
  end;
  pthread_mutex_lock( fMessagesWaitingSpin );
  try
    //- Check for a message, no point waiting if there are messages.
    fMessagesWaiting := inherited Pull(aMessage,FALSE);
    if fMessagesWaiting then begin
      Result := True;
      exit;
    end;
    //- Wait for a message
    while not fMessagesWaiting do begin
      pthread_cond_wait(fMessagesWaitingSignal, fMessagesWaitingSpin);
      fMessagesWaiting := inherited Pull(aMessage,FALSE);
    end;
    Result := True;
  finally
    pthread_mutex_unlock(fMessagesWaitingSpin);
  end;
end;

procedure TMessageChannel.LockResponse;
begin
  pthread_mutex_lock(fResponseSpin);
end;

procedure TMessageChannel.UnlockResponse;
begin
  pthread_mutex_unlock(fResponseSpin);
end;

function TMessageChannel.Push( Pipe: IMessagePipe; MessageValue: uint32; ParamA: NativeUInt; ParamB: NativeUInt; WaitFor: Boolean = False ): TMessageResponse;
var
  aMessage: TMessage;
  Status: boolean;
begin
  Result.Sent := False;
  if not assigned(Pipe) then begin
    exit;
  end;
  pthread_mutex_lock(fMessagesWaitingSpin);
  try
    aMessage.MessageValue := MessageValue;
    aMessage.ParamA := ParamA;
    aMessage.ParamB := ParamB;
    aMessage.Handled := False;
    aMessage.Original := @aMessage;
    aMessage.LockResponse := nil;
    aMessage.UnLockResponse := nil;
    if WaitFor then begin
      aMessage.LockResponse := LockResponse;
      aMessage.UnlockResponse := UnlockResponse;
    end;
    //- Push message
    Status := Pipe.Push(aMessage);
    if not Status then begin
      exit;
    end;
    fMessagesWaiting := True;
    pthread_cond_signal(fMessagesWaitingSignal);
  finally
    pthread_mutex_unlock(fMessagesWaitingSpin);
  end;
  Result.Sent := True;
  //- If WaitFor, then look for a message response.
  if not WaitFor then begin
    exit;
  end;
  pthread_mutex_lock(fResponseSpin);
  try
    //- Check for a message, no point waiting if there are messages.
    if aMessage.Handled then begin
      Result.ParamA := aMessage.ParamA;
      Result.ParamB := aMessage.ParamB;
      exit;
    end;
    //- Wait for a message
    while not aMessage.Handled do begin
      pthread_cond_wait(fMessagesWaitingSignal, fResponseSpin);
    end;
    Result.ParamA := aMessage.ParamA;
    Result.ParamB := aMessage.ParamB;
  finally
    pthread_mutex_unlock(fResponseSpin);
  end;
end;

procedure TMessageChannel.SignalHandled;
begin
  pthread_cond_signal(fResponseSignal);
end;

end.
