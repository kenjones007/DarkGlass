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
unit dg.threading.messagepipe.common;

interface
uses
  dg.threading.types,
  dg.threading.messagepipe;

type
  {$A8} //- Align 8-byte boundary for atomic read/write of fPushIndex and fPullIndex.
  TCommonMessagePipe = class( TInterfacedObject, IMessagePipe )
  private
    fPushIndex: uint32;
    fPullIndex: uint32;
    fMessages: array of TMessage;
  private
    class procedure AssignMessage(SourceMessage: TMessage; var TargetMessage: TMessage); static;
  private //- IMessagePipe -//
    function Push( aMessage: TMessage ): boolean;
    function Pull( var aMessage: TMessage ): boolean;
  public
    constructor Create( BufferSize: uint32 = 128 ); reintroduce;
    destructor Destroy; override;
  end;

implementation

constructor TCommonMessagePipe.Create( BufferSize: uint32 );
begin
  inherited Create;
  fPushIndex := 0;
  fPullIndex := 0;
  SetLength(fMessages,BufferSize);
end;

destructor TCommonMessagePipe.Destroy;
begin
  SetLength(fMessages,0);
  inherited Destroy;
end;

class procedure TCommonMessagePipe.AssignMessage( SourceMessage: TMessage; var TargetMessage: TMessage );
begin
  Move( SourceMessage, TargetMessage, Sizeof(TMessage) );
end;

function TCommonMessagePipe.Pull(var aMessage: TMessage): boolean;
var
  NewIndex: uint32;
begin
  Result := False;
  if fPullIndex=fPushIndex then begin
    exit;
  end;
  AssignMessage( fMessages[fPullIndex], aMessage );
  NewIndex := succ(fPullIndex);
  if NewIndex>=Length(fMessages) then begin
    NewIndex := 0;
  end;
  fPullIndex := NewIndex;
  Result := True;
end;

function TCommonMessagePipe.Push(aMessage: TMessage): boolean;
var
  NewIndex: uint32;
begin
  Result := False;
  NewIndex := succ(fPushIndex);
  if (NewIndex>=Length(fMessages)) then begin
    NewIndex := 0;
  end;
  if NewIndex=fPullIndex then begin
    Exit;
  end;
  AssignMessage( aMessage, fMessages[fPushIndex] );
  fPushIndex := NewIndex;
  Result := True;
end;

end.
