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
unit dg.platform.displaymanager.android;

interface
uses
  dg.platform.display,
  dg.platform.displaymanager;

type
  TDisplayManager = class( TInterfacedObject, IDisplayManager )
  private
    fDisplay: IDisplay;
  private //- IDisplayManager -//
    function getCount: uint32;
    function getDisplay( idx: uint32 ): IDisplay;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation
uses
  dg.platform.display.android;

{ TDisplayManager }

constructor TDisplayManager.Create;
begin
  inherited Create;
  fDisplay := TDisplay.Create;
end;

destructor TDisplayManager.Destroy;
begin
  fDisplay := nil;
  inherited Destroy;
end;

function TDisplayManager.getCount: uint32;
begin
  Result := 0;
  if assigned(fDisplay) then begin
    Result := 1;
  end;
end;

function TDisplayManager.getDisplay(idx: uint32): IDisplay;
begin
  Result := nil;
  if idx<>0 then begin
    exit;
  end;
  if not assigned(fDisplay) then begin
    exit;
  end;
  Result := fDisplay;
end;

end.
