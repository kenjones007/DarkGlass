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
    fMessagesWaitingCS: _RTL_CRITICAL_SECTION;
    fMessagesWaitingSignal: CONDITION_VARIABLE;
  protected //- IMessageChannel -//
    function Pull( var aMessage: TMessage; WaitFor: boolean = False ): boolean; override;
    function Push(Pipe: IMessagePipe; aMessage: TMessage ): boolean; override;

  public
    constructor Create( aName: string ); reintroduce;
    destructor Destroy; override;
  end;


implementation

{ TMessageChannel }

constructor TMessageChannel.Create( aName: string );
begin
  inherited Create( aName );
  fMessagesWaiting := False;
  InitializeConditionVariable(fMessagesWaitingSignal);
  InitializeCriticalSection(fMessagesWaitingCS);
end;

destructor TMessageChannel.Destroy;
begin
  DeleteCriticalSection(fMessagesWaitingCS);
  inherited Destroy;
end;

function TMessageChannel.Pull(var aMessage: TMessage; WaitFor: boolean): boolean;
begin
  Result := False;
  if not WaitFor then begin
    Result := inherited Pull(aMessage,FALSE);
    exit;
  end;
  //-
  EnterCriticalSection(fMessagesWaitingCS);
  try
    //- Check for a message, no point waiting if there are messages.
    fMessagesWaiting := inherited Pull(aMessage,FALSE);
    if fMessagesWaiting then begin
      Result := True;
      exit;
    end;
    //- Wait for a message
    while not fMessagesWaiting do begin
      SleepConditionVariableCS(fMessagesWaitingSignal, fMessagesWaitingCS, INFINITE);
      fMessagesWaiting := inherited Pull(aMessage,FALSE);
    end;
    Result := True;
  finally
    LeaveCriticalSection(fMessagesWaitingCS);
  end;
end;

function TMessageChannel.Push(Pipe: IMessagePipe; aMessage: TMessage): boolean;
begin
  Result := False;
  if not assigned(Pipe) then begin
    exit;
  end;
  EnterCriticalSection(fMessagesWaitingCS);
  try
    //- Push message
    Result := Pipe.Push(aMessage);
    if not Result then begin
      exit;
    end;
    //-
    fMessagesWaiting := True;
    WakeConditionVariable(fMessagesWaitingSignal);
  finally
    LeaveCriticalSection(fMessagesWaitingCS);
  end;
end;

end.
