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
{$ifdef MSWINDOWS}
uses
  dg.platform.platform,
  dg.platform.platform.common;

type
  TPlatform = class( TCustomPlatform, IPlatform )
  private
    function Initialize: boolean; override;
    procedure Run;  override;
    function Finalize: boolean;  override;
  end;

{$endif}
implementation
{$ifdef MSWINDOWS}
uses
  dg.platform.mainloop.windows,
  Windows,
  Messages,
  sysutils;

{ TPlatform }

function TPlatform.Finalize: boolean;
begin
  Result := True;
end;

function TPlatform.Initialize: boolean;
begin
  Result := True;
  fThreadEngine.Threads[0].InstallSubsystem(TMainLoop.Create);
end;

procedure TPlatform.Run;
begin
  inherited Run;
end;

{$endif}
end.
