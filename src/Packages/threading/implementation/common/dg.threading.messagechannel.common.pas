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
unit dg.threading.messagechannel.common;

interface
uses
  system.generics.collections,
  dg.threading.types,
  dg.threading.messagepipe,
  dg.threading.messagechannel;

type
  TCommonMessageChannel = class( TInterfacedObject, IMessageChannel )
  private
    fName: string;
    fPipes: TList<IMessagePipe>;
    fPipeIndex: uint32;
  private //- IMessageChannel -//
    function getName: string;
    function getPipe: IMessagePipe;

  protected //- IMessageChannel -// - Must be overridden
    function Pull( var aMessage: TMessage; WaitFor: boolean = False ): boolean; virtual;
    function Push( Pipe: IMessagePipe; aMessage: TMessage ): boolean; virtual;

  public
    constructor Create( aName: string ); reintroduce;
    destructor Destroy; override;
  end;

implementation
uses
  sysutils,
  dg.threading.messagepipe.common;

{ TMessageChannel }

constructor TCommonMessageChannel.Create( aName: string );
begin
  inherited Create;
  fName := aName;
  fPipes := TList<IMessagePipe>.Create;
  fPipeIndex := 0;
end;

destructor TCommonMessageChannel.Destroy;
begin
  fPipes.DisposeOf;
  inherited Destroy;
end;

function TCommonMessageChannel.getName: string;
begin
  Result := fName;
end;

function TCommonMessageChannel.getPipe: IMessagePipe;
var
  NewPipe: IMessagePipe;
begin
  NewPipe := TCommonMessagePipe.Create();
  fPipes.Add(NewPipe);
  Result := NewPipe;
end;

function TCommonMessageChannel.Pull(var aMessage: TMessage; WaitFor: boolean): boolean;
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


function TCommonMessageChannel.Push(Pipe: IMessagePipe; aMessage: TMessage): boolean;
begin
  //- This should be overriden and therefore never called.
  Sleep(1);
end;

end.
