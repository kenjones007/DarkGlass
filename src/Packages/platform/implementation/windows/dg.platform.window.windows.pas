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
unit dg.platform.window.windows;

interface
{$ifdef MSWINDOWS}
uses
  Windows,
  dg.platform.window;

type
  TWindow = class( TInterfacedObject, IWindow )
  private
    fHandle: hwnd;
  private
    procedure CreateWindow(aTitle: pWideChar; aTop, aLeft, aWidth, aHeight: int32; aFullscreen: boolean);
  protected
    function getHandle: pointer;
    function HandleWindowMessage( uMsg: uint32; wParam: NativeUInt; lParam: NativeUInt ): NativeUInt;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

{$endif}
implementation
{$ifdef MSWINDOWS}
uses
  Classes,
  Messages,
  sysutils;

const
  cDarkGlassClass = 'darkGlass';

var
  WindowList: TList;

constructor TWindow.Create;
begin
  inherited Create;
  fHandle := hwnd(nil);
  WindowList.Add(Self);
  CreateWindow( 'Darkglass test',0,0,200,200,FALSE );
end;

destructor TWindow.Destroy;
begin
  WindowList.Remove(Self);
  DestroyWindow(fHandle);
  inherited Destroy;
end;

function TWindow.getHandle: pointer;
begin
  result := pointer(fHandle);
end;

procedure TWindow.CreateWindow( aTitle: pWideChar; aTop, aLeft, aWidth, aHeight: int32; aFullscreen: boolean );
var
  StyleEx: uint32;
begin
  //- Set window style.
  if aFullscreen then begin
    StyleEx := WS_POPUPWINDOW;
    //    fDisplay.SetResolution(aWidth,aHeight); //- change display mode!
  end else begin
    StyleEx := WS_CLIPSIBLINGS or WS_CLIPCHILDREN or WS_OVERLAPPEDWINDOW;
  end;
  //- Call OS to create window
  fHandle := CreateWindowExW( WS_EX_APPWINDOW, cDarkGlassClass, aTitle, StyleEx, aLeft, aTop, aWidth, aHeight, 0, 0, system.MainInstance, nil );
  UpdateWindow(fHandle);
  ShowWindow(fHandle, SW_SHOW);
end;

function TWindow.HandleWindowMessage(uMsg: uint32; wParam, lParam: NativeUInt): NativeUInt;
begin
  case uMsg of

    WM_CLOSE: begin
      SendMessage(System.MainInstance,WM_DESTROY,0,0);
      Result := 0;
    end;

    else begin
      Result := DefWindowProc(fHandle, uMsg, wParam, lParam);
    end;

  end;
end;

function WindowProc( Handle: HWND; uMsg: uint32; wParam: NativeUInt; lParam: NativeUInt ): NativeUInt; stdcall;
var
  idx: uint32;
begin
  if WindowList.Count=0 then begin
    Result := DefWindowProc(Handle, uMsg, wParam, lParam);
    exit;
  end;
  for idx := 0 to pred(WindowList.Count) do begin
    if TWindow(WindowList.Items[idx]).getHandle=pointer(Handle) then begin
      Result := TWindow(WindowList.Items[idx]).HandleWindowMessage( uMsg, wParam, lParam );
      Exit;
    end;
  end;
  Result := DefWindowProc(Handle, uMsg, wParam, lParam);
end;

procedure CreateWindowClass;
var
  WndClass: tagWndClass;
begin
  WndClass.style := CS_HREDRAW or CS_VREDRAW or CS_OWNDC;
  WndClass.lpfnWndProc := @WindowProc;
  WndClass.cbClsExtra := 0;
  WndClass.cbWndExtra := 0;
  WndClass.hInstance := System.MainInstance;
  WndClass.hIcon := LoadIconW(0,MakeIntResource(IDI_APPLICATION));
  WndClass.hCursor := LoadCursorW(0,MakeIntResource(IDC_ARROW));
  WndClass.hbrBackground := 0;
  WndClass.lpszMenuName := nil;
  WndClass.lpszClassName := cDarkGlassClass;
  if RegisterClassW(WndClass)=0 then begin
    raise
      Exception.Create('Failed to register darkglass window class.');
  end;
end;

procedure DestroyWindowClass;
begin
  Windows.UnRegisterClass(cDarkGlassClass,system.MainInstance);
end;

initialization
  CreateWindowClass;
  WindowList := TList.Create;

finalization
  WindowList.DisposeOf;
  DestroyWindowClass;

{$endif}
end.
