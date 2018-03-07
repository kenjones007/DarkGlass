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
  TCommonMainLoop = class( TInterfacedObject, ISubSystem )
  private //- Platform Message Channel
    fFirstRun: boolean;
    fPlatformChannel: IMessageChannel;
    fGameChannel: THChannelConnection;
  private //- Window management -//
    fMainWindow: IWindow;
    fWindows: TList<IWindow>;
  private
    procedure SendInitializedMessage;
    procedure HandlePlatformMessages( MessageValue: uint32; var ParamA: NativeUInt; var ParamB: NativeUInt; var Handled: boolean );
    procedure doCreateWindow( var ParamA: NativeUInt; var ParamB: NativeUInt );
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
  SysUtils,
  dg.darkmessages.platform,
  dg.darkmessages.game;

{ TCommonMainLoop }

constructor TCommonMainLoop.Create;
begin
  inherited Create;
  fFirstRun := True;
  fPlatformChannel := nil;
  fMainWindow := nil;
  fWindows := TList<IWindow>.Create;
end;

destructor TCommonMainLoop.Destroy;
begin
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

function TCommonMainLoop.Execute: boolean;
begin
  Result := True;
  if fFirstRun then begin
    fFirstRun := False;
    SendInitializedMessage;
  end;
  HandleOSMessages;
  fPlatformChannel.ProcessMessages(HandlePlatformMessages, False);
  //- Render
end;

procedure TCommonMainLoop.Finalize;
begin
  fPlatformChannel := nil;
end;

procedure TCommonMainLoop.HandlePlatformMessages( MessageValue: uint32; var ParamA: NativeUInt; var ParamB: NativeUInt; var Handled: boolean );
begin
  Handled := True;
  //- Handle Message.
  case MessageValue of
    MSG_CREATE_WINDOW: doCreateWindow( ParamA, ParamB );
    else begin
      Handled := False;
    end;
  end;
end;

function TCommonMainLoop.Initialize: boolean;
begin
  Result := True;
  fGameChannel := MessageBus.GetConnection('game');
  if fGameChannel=0 then begin
    raise Exception.Create('Main loop was unable to acquire channel access to game thread.');
  end;
end;

procedure TCommonMainLoop.Install;
begin
  fPlatformChannel := MessageBus.CreateMessageChannel('platform');
end;

procedure TCommonMainLoop.SendInitializedMessage;
begin
  if not MessageBus.SendMessage(fGameChannel,MSG_PLATFORM_INITIALIZED,0,0,True).Sent then begin
    raise Exception.Create('Main loop could not initialized game thread, due to full message buffer.');
  end;
end;

end.
