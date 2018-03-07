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
unit dg.platform.game.common;

interface
uses
  SyncObjs,
  dg.platform.platform,
  dg.threading;

type
  //- Handles messages being sent back to game-land.
  TCommonGame = class( TInterfacedObject, ISubSystem )
  private //- Game message channel.
    fGameChannel: IMessageChannel;
    fGameMessageHandler: TMessageHandler;
  private
    procedure HandleGameMessages( MessageValue: uint32; var ParamA: NativeUInt; var ParamB: NativeUInt; var Handled: boolean );
  protected //- ISubSystem -//
    procedure Install;
    function Initialize: boolean;
    function Execute: boolean;
    procedure Finalize;
  public
    constructor Create( MessageHandler: TMessageHandler ); reintroduce;
  end;

implementation
uses
  dg.darkmessages.game;

{ TCommonGame }

constructor TCommonGame.Create(MessageHandler: TMessageHandler);
begin
  inherited Create;
  fGameMessageHandler := MessageHandler;
end;

function TCommonGame.Execute: boolean;
begin
  fGameChannel.ProcessMessages(HandleGameMessages, True);
end;

procedure TCommonGame.Finalize;
begin
  exit;
end;

procedure TCommonGame.HandleGameMessages(MessageValue: uint32; var ParamA, ParamB: NativeUInt; var Handled: boolean);
var
  GameMessageHandler: TMessageHandler;
begin
  //-  Handle messages intended for the game.
  GameMessageHandler := fGameMessageHandler; //- Atomic
  if assigned(GameMessageHandler) then begin
    Handled := GameMessageHandler( MessageValue, ParamA, ParamB );
  end;
end;

function TCommonGame.Initialize: boolean;
begin
  Result := True;
end;

procedure TCommonGame.Install;
begin
  fGameChannel := MessageBus.CreateMessageChannel('game');
end;


end.
