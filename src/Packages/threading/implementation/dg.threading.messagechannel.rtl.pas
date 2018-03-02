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
unit dg.threading.messagechannel.rtl;

interface
uses
  system.generics.collections,
  dg.threading.types,
  dg.threading.messagepipe,
  dg.threading.messagechannel;

type
  TMessageChannel = class( TInterfacedObject, IMessageChannel )
  private
    fName: string;
    fPipes: TList<IMessagePipe>;
    fPipeIndex: uint32;
  private //- IMessageChannel -//
    function getName: string;
    function Pull( var aMessage: TMessage ): boolean;
    function getPipe: IMessagePipe;
  public
    constructor Create( aName: string ); reintroduce;
    destructor Destroy; override;
  end;

implementation
uses
  dg.threading.messagepipe.rtl;

{ TMessageChannel }

constructor TMessageChannel.Create( aName: string );
begin
  inherited Create;
  fName := aName;
  fPipes := TList<IMessagePipe>.Create;
  fPipeIndex := 0;
end;

destructor TMessageChannel.Destroy;
begin
  fPipes.DisposeOf;
  inherited Destroy;
end;

function TMessageChannel.getName: string;
begin
  Result := fName;
end;

function TMessageChannel.getPipe: IMessagePipe;
var
  NewPipe: IMessagePipe;
begin
  NewPipe := TMessagePipe.Create;
  fPipes.Add(NewPipe);
  Result := NewPipe;
end;

function TMessageChannel.Pull(var aMessage: TMessage): boolean;
var
  idx: uint32;
begin
  Result := False;
  if fPipes.Count=0 then begin
    exit;
  end;
  idx := fPipeIndex;
  repeat
    Result := fPipes[idx].Pull(aMessage);
    inc(idx);
    if idx>=pred(fPipes.Count) then begin
      idx := 0;
    end;
  until (idx=fPipeIndex) or (Result=True);
  fPipeIndex := idx;
end;

end.
