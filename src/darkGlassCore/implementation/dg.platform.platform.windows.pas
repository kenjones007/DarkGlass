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
unit dg.platform.platform.windows;

interface
uses
  dg.platform.window,
  dg.platform.platform;

type
  TPlatform = class( TInterfacedObject, IPlatform )
  private
    fMainWindow: IWindow;
  private
    function Initialize: boolean;
    procedure Run;
    function Finalize: boolean;
  end;

implementation
uses
  dg.platform.window.windows,
  Windows,
  Messages,
  sysutils;

{ TPlatform }

function TPlatform.Finalize: boolean;
begin
  fMainWindow := nil;
  Result := True;
end;

function TPlatform.Initialize: boolean;
begin
  Result := True;
  fMainWindow := TWindow.Create;
end;

procedure TPlatform.Run;
var
  aMessage: tagMsg;
begin
  while (True) do begin
    if Windows.PeekMessage(aMessage,0,0,0,PM_REMOVE) then begin
       TranslateMessage(aMessage);
       DispatchMessage(aMessage);
       if aMessage.message=WM_QUIT then begin
         exit;
       end;
    end;
  end;
end;

end.
