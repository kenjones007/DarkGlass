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
unit dg.threading.messagechannel.windows;

interface
uses
  Windows,
  system.syncobjs,
  dg.threading.types,
  dg.threading.messagepipe,
  dg.threading.messagechannel,
  dg.threading.messagechannel.common;


type
  TMessageChannel = class( TCommonMessageChannel, IMessageChannel )
  private
    fMessagesWaiting: boolean;
    fMessagesWaitingSpin: _RTL_SRWLOCK;
    fMessagesWaitingSignal: CONDITION_VARIABLE;
    fResponseSpin: _RTL_SRWLOCK;
    fResponseSignal: CONDITION_VARIABLE;
  private
    procedure LockResponse;
    procedure UnlockResponse;
  protected
    function Pull( var aMessage: TMessage; WaitFor: boolean = False ): boolean; override;
    procedure SignalHandled; override;

  protected //- IMessageChannel -//
    function Push( Pipe: IMessagePipe; MessageValue: uint32; ParamA: NativeUInt; ParamB: NativeUInt; WaitFor: Boolean = False ): TMessageResponse; override;

  public
    constructor Create( aName: string ); reintroduce;
  end;


implementation
uses
  Sysutils;

{ TMessageChannel }

constructor TMessageChannel.Create( aName: string );
begin
  inherited Create( aName );
  fMessagesWaiting := False;
  InitializeConditionVariable(fMessagesWaitingSignal);
  InitializeConditionVariable(fResponseSignal);
  InitializeSRWLock(fMessagesWaitingSpin);
  InitializeSRWLock(fResponseSpin);
end;

function TMessageChannel.Pull(var aMessage: TMessage; WaitFor: boolean): boolean;
var
  Error: dword;
begin
  if not WaitFor then begin
    Result := inherited Pull(aMessage,FALSE);
    exit;
  end;
  //-
  AcquireSRWLockExclusive(fMessagesWaitingSpin);
  try
    //- Check for a message, no point waiting if there are messages.
    fMessagesWaiting := inherited Pull(aMessage,FALSE);
    if fMessagesWaiting then begin
      Result := True;
      exit;
    end;
    //- Wait for a message
    while not fMessagesWaiting do begin
      if not SleepConditionVariableSRW(fMessagesWaitingSignal, fMessagesWaitingSpin, INFINITE, 0) then begin
        Error:=GetLastError;
        if Error<>ERROR_TIMEOUT then begin
          raise
            Exception.Create('A windows API error occurred on SleepConditionVariableSRW. ('+IntToStr(Error)+')');
        end;
      end;
      fMessagesWaiting := inherited Pull(aMessage,FALSE);
    end;
    Result := True;
  finally
    ReleaseSRWLockExclusive(fMessagesWaitingSpin);
  end;
end;

procedure TMessageChannel.LockResponse;
begin
  AcquireSRWLockExclusive(fResponseSpin);
end;

procedure TMessageChannel.UnlockResponse;
begin
  ReleaseSRWLockExclusive(fResponseSpin);
end;

function TMessageChannel.Push( Pipe: IMessagePipe; MessageValue: uint32; ParamA: NativeUInt; ParamB: NativeUInt; WaitFor: Boolean = False ): TMessageResponse;
var
  aMessage: TMessage;
  Error: DWord;
  Status: boolean;
begin
  //- Send the message to the target thread.
  Result.Sent := False;
  if not assigned(Pipe) then begin
    exit;
  end;
  AcquireSRWLockExclusive(fMessagesWaitingSpin);
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
    WakeConditionVariable(fMessagesWaitingSignal);
  finally
    ReleaseSRWLockExclusive(fMessagesWaitingSpin);
  end;
  Result.Sent := True;
  //- If WaitFor, then look for a message response.
  if not WaitFor then begin
    exit;
  end;
  AcquireSRWLockExclusive(fResponseSpin);
  try
    //- Check for a message, no point waiting if there are messages.
    if aMessage.Handled then begin
      Result.ParamA := aMessage.ParamA;
      Result.ParamB := aMessage.ParamB;
      exit;
    end;
    //- Wait for a message
    while not aMessage.Handled do begin
      if not SleepConditionVariableSRW(fResponseSignal, fResponseSpin, INFINITE, 0) then begin
        Error:=GetLastError;
        if Error<>ERROR_TIMEOUT then begin
          raise
            Exception.Create('A windows API error occurred on SleepConditionVariableSRW. ('+IntToStr(Error)+')');
        end;
      end;
    end;
    Result.ParamA := aMessage.ParamA;
    Result.ParamB := aMessage.ParamB;
  finally
    ReleaseSRWLockExclusive(fResponseSpin);
  end;
end;

procedure TMessageChannel.SignalHandled;
begin
  WakeConditionVariable(fResponseSignal);
end;

end.
