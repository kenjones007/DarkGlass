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
unit dg.messaging.messagebus.standard;

interface
uses
  system.generics.collections,
  dg.messaging.messagepipe,
  dg.messaging.messagechannel,
  dg.messaging.messagebus;

type
  TMessageBus = class( TInterfacedObject, IMessageBus )
  private
    fChannels: TList<IMessageChannel>;
  private //- IMessageBus -//
    function CreateMessageChannel( name: string ): IMessageChannel;
    function GetMessagePipe( ChannelName: string ): IMessagePipe;
  private
    function FindChannelByName( name: string ): IMessageChannel;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation
uses
  sysutils,
  dg.messaging.messagechannel.standard;

{ TMessageBus }

constructor TMessageBus.Create;
begin
  inherited Create;
  fChannels := TList<IMessageChannel>.Create;
end;

function TMessageBus.CreateMessageChannel(name: string): IMessageChannel;
var
  aChannel: IMessageChannel;
begin
  Result := nil;
  aChannel := FindChannelByName( name );
  if assigned(aChannel) then begin
    exit;
  end;
  aChannel := TMessageChannel.Create( Uppercase(Trim(name)) );
  fChannels.Add(aChannel);
  Result := aChannel;
end;

destructor TMessageBus.Destroy;
begin
  fChannels.DisposeOf;
  inherited Destroy;
end;

function TMessageBus.FindChannelByName(name: string): IMessageChannel;
var
  idx: uint32;
  utName: string;
begin
  Result := nil;
  utName := Uppercase(Trim(Name));
  if fChannels.Count=0 then begin
    exit;
  end;
  for idx := 0 to pred(fChannels.Count) do begin
    if fChannels[idx].Name=utName then begin
      Result := fChannels[idx];
      exit;
    end;
  end;
end;

function TMessageBus.GetMessagePipe(ChannelName: string): IMessagePipe;
var
  aChannel: IMessageChannel;
begin
  Result := nil;
  aChannel := FindChannelByName(ChannelName);
  if not assigned(aChannel) then begin
    exit;
  end;
  Result := aChannel.getPipe;
end;

end.
