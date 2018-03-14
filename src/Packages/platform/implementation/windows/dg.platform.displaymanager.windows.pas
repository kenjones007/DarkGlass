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
unit dg.platform.displaymanager.windows;

interface
uses
  system.generics.collections,
  dg.platform.display,
  dg.platform.displaymanager;

type
  TDisplayManager = class( TInterfacedObject, IDisplayManager )
  private
    fDisplays: TList<IDisplay>;
  private //- IDisplayManager -//
    function getCount: uint32;
    function getDisplay( idx: uint32 ): IDisplay;
  private
    procedure CreateDisplayWithDimensions(Name: string; left, top, right, bottom: int32);
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation
uses
  WinApi.Windows,
  SysUtils,
  classes,
  MultiMon,
  dg.platform.display.windows;

function EnumDisplayMonitors(hdc: HDC; lprcIntersect: PRect; lpfnEnumProc: pointer; lData: LPARAM): Boolean; stdcall; external 'User32.dll';

type
  R = record
    left: int32;
    top: int32;
    right: int32;
    bottom: int32;
  end;
  pR = ^R;

function MonitorEnumProc( Handle: THandle; hdcMonitor: HDC; lprcMonitor: pR; dwData: NativeUInt ): boolean; stdcall;
var
  MonitorInfo: TMonitorInfoEx;
  Str: string;
begin
  Result := True;
  FillChar(MonitorInfo,sizeof(TMonitorInfoEx),0);
  MonitorInfo.cbSize := SizeOf(MonitorInfo);
  if GetMonitorInfo(Handle, @MonitorInfo) then begin
    Str := MonitorInfo.szDevice;
    TDisplayManager(pointer(dwData)).CreateDisplayWithDimensions(Str,lprcMonitor^.left,lprcMonitor^.top,lprcMonitor^.right,lprcMonitor^.bottom);
  end else begin
    RaiseLastOSError;
  end;
end;

procedure TDisplayManager.CreateDisplayWithDimensions( Name: string; left: int32; top: int32; right: int32; bottom: int32 );
var
  NewDisplay: IDisplay;
begin
  NewDisplay := TDisplay.Create( fDisplays.Count, Name, left, top, right, bottom );
  fDisplays.Add(NewDisplay);
end;

constructor TDisplayManager.Create;
begin
  inherited Create;
  fDisplays := TList<IDisplay>.Create;
  EnumDisplayMonitors(0,nil, @MonitorEnumProc,NativeUInt(Self));
end;

destructor TDisplayManager.Destroy;
begin
  fDisplays.DisposeOf;
  inherited Destroy;
end;

function TDisplayManager.getCount: uint32;
begin
  Result := fDisplays.Count;
end;

function TDisplayManager.getDisplay(idx: uint32): IDisplay;
begin
  Result := fDisplays.Items[idx];
end;

end.
