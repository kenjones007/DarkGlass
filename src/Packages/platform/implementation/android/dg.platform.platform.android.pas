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
uses
  dg.platform.platform,
  dg.platform.platform.common;

type
  TPlatform = class( TCommonPlatform, IPlatform )
  private
  protected //- IPlatform -//
    function Initialize: boolean; override;
    function Finalize: boolean; override;
    procedure Run; override;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation
uses
 dg.platform.mainloop.android,
 sysutils;

{ TPlatform }

constructor TPlatform.Create;
begin
  inherited Create;
end;

destructor TPlatform.Destroy;
begin
  inherited Destroy;
end;

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

end.
