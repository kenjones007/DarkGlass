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
unit dg.threading.messagebus.common;

interface
uses
  system.generics.collections,
  dg.threading.types,
  dg.threading.messagepipe,
  dg.threading.messagechannel,
  dg.threading.messagebus;

type
  TCommonMessageBus = class( TInterfacedObject, IMessageBus )
  private
    fChannels: TList<IMessageChannel>;
    //- For storing handles.
    fConnectionChannels: TList<IMessageChannel>;
    fConnectionPipes: TList<IMessagePipe>;
  private
    function FindChannelByName( name: string ): IMessageChannel;
  private //- IMessageBus -//
    function CreateMessageChannel( ChannelName: string ): IMessageChannel;
    function GetConnection( ChannelName: string ): THChannelConnection;
    function SendMessage( Connection: THChannelConnection; MessageValue: uint32; ParamA: NativeUInt; ParamB: NativeUInt; WaitFor: Boolean = False ): TMessageResponse;
  protected //- Override me -//
    function NewMessageChannel( ChannelName: string ): IMessageChannel; virtual; abstract;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation
uses
  sysutils,
  dg.threading.messagechannel.common;

{ TMessageBus }

constructor TCommonMessageBus.Create;
begin
  inherited Create;
  fChannels := TList<IMessageChannel>.Create;
  fConnectionChannels := TList<IMessageChannel>.Create;
  fConnectionPipes := TList<IMessagePipe>.Create;
end;

function TCommonMessageBus.CreateMessageChannel(ChannelName: string): IMessageChannel;
var
  aChannel: IMessageChannel;
begin
  Result := nil;
  aChannel := FindChannelByName( ChannelName );
  if assigned(aChannel) then begin
    Result := aChannel;
    exit;
  end;
  aChannel := NewMessageChannel( Uppercase(Trim(ChannelName)) );
  fChannels.Add(aChannel);
  Result := aChannel;
end;

destructor TCommonMessageBus.Destroy;
begin
  fConnectionChannels.DisposeOf;
  fConnectionPipes.DisposeOf;
  fChannels.DisposeOf;
  inherited Destroy;
end;

function TCommonMessageBus.FindChannelByName(name: string): IMessageChannel;
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

function TCommonMessageBus.GetConnection(ChannelName: string): THChannelConnection;
var
  aChannel: IMessageChannel;
  aPipe: IMessagePipe;
begin
  Result := 0;
  aChannel := FindChannelByName(ChannelName);
  if not assigned(aChannel) then begin
    exit;
  end;
  aPipe := aChannel.getPipe;
  if not assigned(aPipe) then begin
    exit;
  end;
  fConnectionChannels.Add(aChannel);
  fConnectionPipes.Add(aPipe);
  Result := fConnectionPipes.Count;
end;

function TCommonMessageBus.SendMessage( Connection: THChannelConnection; MessageValue: uint32; ParamA: NativeUInt; ParamB: NativeUInt; WaitFor: Boolean = False ): TMessageResponse;
var
  idx: uint32;
  Channel: IMessageChannel;
  Pipe: IMessagePipe;
begin
  Result.Sent := False;
  if Connection=0 then begin
    exit;
  end;
  if Connection>fConnectionPipes.Count then begin
    exit;
  end;
  idx := pred(Connection);
  Pipe := fConnectionPipes[idx];
  Channel := fConnectionChannels[idx];
  Result := Channel.Push(Pipe, MessageValue, ParamA, ParamB, WaitFor );
end;

end.
