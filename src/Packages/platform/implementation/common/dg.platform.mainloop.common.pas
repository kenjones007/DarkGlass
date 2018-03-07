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
unit dg.platform.mainloop.common;

interface
uses
  system.generics.collections,
  SyncObjs,
  dg.threading,
  dg.platform.window;

type
  // Handler proc for 'game' messages
  TMessageHandler = function( MessageValue: uint32; var ParamA: NativeUInt; var ParamB: NativeUInt ): boolean;

  TCommonMainLoop = class( TInterfacedObject, ISubSystem )
  private //- Platform Message Channel
    fPlatformChannel: IMessageChannel;
  private //- Game message channel.
    fGameChannel: IMessageChannel;
    fGameChannelSend: THChannelConnection;
    fGameMessageHandler: TMessageHandler;
    fGameMessageHandlerCS: TCriticalSection;
  private //- Window management -//
    fMainWindow: IWindow;
    fWindows: TList<IWindow>;
  private
    procedure HandlePlatformMessages( MessageValue: uint32; var ParamA: NativeUInt; var ParamB: NativeUInt; var Handled: boolean );
    procedure HandleGameMessages( MessageValue: uint32; var ParamA: NativeUInt; var ParamB: NativeUInt; var Handled: boolean );
    procedure doCreateWindow( var ParamA: NativeUInt; var ParamB: NativeUInt );
    procedure doSetCallback( var ParamA: NativeUInt; var ParamB: NativeUInt );
  protected //- ISubSystem -//
    procedure Install; virtual;
    function Initialize: boolean; virtual;
    function Execute: boolean; virtual;
    procedure Finalize; virtual;

  protected //- Override me -//
    procedure HandleOSMessages; virtual; abstract;
    function CreateWindow(): IWindow; virtual; abstract;

  public
    constructor Create; reintroduce; virtual;
    destructor Destroy; override;
  end;

implementation
uses
  dg.darkmessages.platform;

{ TCommonMainLoop }

constructor TCommonMainLoop.Create;
begin
  inherited Create;
  fGameChannelSend := 0;
  fGameMessageHandler := nil;
  fGameChannel := nil;
  fPlatformChannel := nil;
  fMainWindow := nil;
  fWindows := TList<IWindow>.Create;
  fGameMessageHandlerCS := TCriticalSection.Create;
end;

destructor TCommonMainLoop.Destroy;
begin
  fGameMessageHandler := nil;
  fGameChannelSend := 0;
  fGameMessageHandlerCS.DisposeOf;
  fGameChannel := nil;
  fPlatformChannel := nil;
  fMainWindow := nil;
  fWindows.DisposeOf;
  inherited Destroy;
end;

procedure TCommonMainLoop.doCreateWindow(var ParamA: NativeUInt; var ParamB: NativeUInt);
var
  NewWindow: IWindow;
begin
  NewWindow := CreateWindow();
  ParamA := NativeUInt(pointer(NewWindow));
  if not assigned(NewWindow) then begin
    exit;
  end;
  if not assigned(fMainWindow) then begin
    fMainWindow := NewWindow;
  end;
  fWindows.Add(NewWindow);
end;

procedure TCommonMainLoop.doSetCallback(var ParamA: NativeUInt; var ParamB: NativeUInt);
begin
  fGameMessageHandlerCS.Acquire;
  try
    fGameMessageHandler := TMessageHandler(pointer(ParamA));
  finally
    fGameMessageHandlerCS.Release;
  end;
end;

function TCommonMainLoop.Execute: boolean;
begin
  Result := True;
  HandleOSMessages;
  fPlatformChannel.ProcessMessages(HandlePlatformMessages, False);
  fGameChannel.ProcessMessages(HandleGameMessages, False);
  //- Render
end;

procedure TCommonMainLoop.Finalize;
begin
  fPlatformChannel := nil;
end;

procedure TCommonMainLoop.HandleGameMessages( MessageValue: uint32; var ParamA: NativeUInt; var ParamB: NativeUInt; var Handled: boolean );
var
  GameMessageHandler: TMessageHandler;
begin
  GameMessageHandler := fGameMessageHandler; //- Atomic
  if assigned(GameMessageHandler) then begin
    Handled := GameMessageHandler( MessageValue, ParamA, ParamB );
  end;
end;

procedure TCommonMainLoop.HandlePlatformMessages( MessageValue: uint32; var ParamA: NativeUInt; var ParamB: NativeUInt; var Handled: boolean );
begin
  Handled := True;
  //- Handle Message.
  case MessageValue of
    MSG_SET_GAME_CALLBACK: doSetCallback( ParamA, ParamB );
    MSG_CREATE_WINDOW: doCreateWindow( ParamA, ParamB );
    else begin
      Handled := False;
    end;
  end;
end;

function TCommonMainLoop.Initialize: boolean;
begin
  fGameChannelSend := MessageBus.GetConnection('game');
  Result := True;
end;

procedure TCommonMainLoop.Install;
begin
  fPlatformChannel := MessageBus.CreateMessageChannel('platform');
  fGameChannel := MessageBus.CreateMessageChannel('game');
end;

end.
