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
unit dg.platform.platform.android;

interface
{$ifdef ANDROID}
uses
  Androidapi.Input,
  Androidapi.NativeActivity,
  Androidapi.JNIBridge,
  Androidapi.JNI.Os,
  Androidapi.Looper,
  Androidapi.AppGlue,
  dg.platform.platform,
  dg.platform.platform.custom;

type
  TPlatform = class( TCustomPlatform, IPlatform )
  private
    procedure HandleApplicationCommand(const App: TAndroidApplicationGlue; const ACommand: TAndroidApplicationCommand);
    function HandleInputEvent(const App: TAndroidApplicationGlue; const AEvent: PAInputEvent): Int32;
  protected //- IPlatform -//
    function Initialize: boolean; override;
    function Finalize: boolean; override;
    procedure Run; override;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

{$endif}
implementation
{$ifdef ANDROID}
uses
 sysutils;

{ TPlatform }

procedure TPlatform.HandleApplicationCommand(const App: TAndroidApplicationGlue; const ACommand: TAndroidApplicationCommand);
begin
  sleep(1);
end;

function TPlatform.HandleInputEvent(const App: TAndroidApplicationGlue; const AEvent: PAInputEvent): Int32;
begin
  Sleep(1);
end;

constructor TPlatform.Create;
begin
  inherited Create;
  app_dummy;
  TAndroidApplicationGlue(PANativeActivity(System.DelphiActivity)^.instance).OnApplicationCommandEvent := HandleApplicationCommand;
  TAndroidApplicationGlue(PANativeActivity(System.DelphiActivity)^.instance).OnInputEvent := HandleInputEvent;
end;

destructor TPlatform.Destroy;
begin
  inherited Destroy;
end;

function TPlatform.Finalize: boolean;
begin
//-
end;

function TPlatform.Initialize: boolean;
begin
//-
end;

procedure TPlatform.Run;
begin
  inherited;
end;

{$endif}
end.
