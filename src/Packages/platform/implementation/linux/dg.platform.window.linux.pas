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
unit dg.platform.window.linux;

interface
uses
  dg.platform.linux.binding.x,
  dg.platform.linux.binding.xlib,
  dg.platform.display,
  dg.platform.window;

type
  TWindow = class( TInterfacedObject, IWindow )
  private
    fAtom: Atom;
    fDisplay: IDisplay;
    fHandle: Window;
  private //- IWindow -//
    procedure CreateWindow;
    function getOSHandle: pointer;
  public
    constructor Create( aDisplay: IDisplay ); reintroduce;
    destructor Destroy; override;
  end;

implementation
uses
  sysutils;

{ TWindow }

constructor TWindow.Create(aDisplay: IDisplay);
begin
  inherited Create;
  fDisplay := aDisplay;
  CreateWindow;
end;

destructor TWindow.Destroy;
begin

  inherited Destroy;
end;

procedure TWindow.CreateWindow;
var
  _visual: Visual;
  Screen: int32;
  Attributes: XSetWindowAttributes;
  Depth: int32;
begin
  Screen := DefaultScreen(fDisplay.getOSHandle);
  _visual := DefaultVisual(fDisplay.getOSHandle,Screen);
  Depth := DefaultDepth(fDisplay.getOSHandle,Screen);
	Attributes.background_pixel := XWhitePixel(fDisplay.getOSHandle,Screen);

  fHandle := XCreateWindow(
      fDisplay.getOSHandle,
      XRootWindow(fDisplay.getOSHandle,Screen),
      0,0,400,400,
      5,
      Depth,
      InputOutput,
      _visual,
      CWBackPixel,
      @Attributes);

  case fHandle of
	    BadAlloc: raise Exception.Create('Bad Alloc');
      BadColor: raise Exception.Create('Bad Color');
     BadCursor: raise Exception.Create('Bad Cursor');
      BadMatch: raise Exception.Create('Bad Match');
     BadPixmap: raise Exception.Create('Bad Pixmap');
      BadValue: raise Exception.Create('Bad Value');
     BadWindow: raise Exception.Create('Bad Window');
  end;

  XSelectInput( fDisplay.getOSHandle, fHandle, ExposureMask or KeyPressMask or StructureNotifyMask );
  fAtom := XInternAtom( fDisplay.getOSHandle, Pointer(MarshaledAString(UTF8Encode('WM_DELETE_WINDOW'))), xFalse);
  XSetWMProtocols(fDisplay.getOSHandle, fHandle, @fAtom, 1);
  XStoreName(fDisplay.getOSHandle, fHandle, Pointer(MarshaledAString(UTF8Encode('Darkglass!'))));

  if (XMapWindow(fDisplay.getOSHandle,fHandle)=BadWindow) then begin
    raise Exception.Create('Bad Window');
  end;
end;

function TWindow.getOSHandle: pointer;
begin
  Result := pointer(fHandle);
end;

end.
