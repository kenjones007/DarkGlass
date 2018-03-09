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
unit dg.platform.windowmanager.linux;

interface
uses
  system.generics.collections,
  dg.platform.linux.binding.xlib,
  dg.platform.windowmanager,
  dg.platform.display,
  dg.platform.window;

type
  TWindowManager = class( TInterfacedObject, IWindowManager )
  private
    fWindows: TList<IWindow>;
  private //- IWindowManager -//
    function getCount: uint32;
    function getWindow( idx: uint32 ): IWindow;
    function CreateWindow( Display: IDisplay ): IWindow;
  public
    procedure HandleWindowMessage( Event: XEvent );
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation
uses
  dg.platform.window.linux;

{ TWindowManager }

constructor TWindowManager.Create;
begin
  inherited Create;
  fWindows := TList<IWindow>.Create;
end;

function TWindowManager.CreateWindow(Display: IDisplay): IWindow;
var
  NewWindow: IWindow;
begin
  NewWindow := TWindow.Create( Display );
  fWindows.Add(NewWindow);
  Result := NewWindow;
end;

destructor TWindowManager.Destroy;
begin
  fWindows.DisposeOf;
  inherited Destroy;
end;

function TWindowManager.getCount: uint32;
begin
  Result := fWindows.Count;
end;

function TWindowManager.getWindow(idx: uint32): IWindow;
begin
  Result := fWindows.Items[idx];
end;

procedure TWindowManager.HandleWindowMessage(Event: XEvent);
begin
  exit;
end;

end.
