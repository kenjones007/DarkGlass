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
unit dg.dynlib.dynlib.windows;

interface
{$ifdef MSWINDOWS}
uses
  Windows,
  dg.dynlib.dynlib;

type
  TDynLib = class( TInterfacedObject, IDynLib )
  private
    fHandle: HMODULE;
  private
    function LoadLibrary( filepath: string ): boolean;
    function FreeLibrary: boolean;
    function GetProcAddress( funcName: string ): pointer;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

{$endif}
implementation
{$ifdef MSWINDOWS}

const
  null = 0;

constructor TDynLib.Create;
begin
  inherited Create;
  fHandle := null;
end;

destructor TDynLib.Destroy;
begin
  if fHandle<>null then begin
    FreeLibrary;
  end;
  inherited Destroy;
end;

function TDynLib.FreeLibrary: boolean;
begin
  Result := True;
  Windows.FreeLibrary(fHandle);
  fHandle := null;
end;

function TDynLib.GetProcAddress( funcName: string ): pointer;
begin
  Result := Windows.GetProcAddress(fHandle,pAnsiChar(UTF8Encode(funcName)));
end;

function TDynLib.LoadLibrary(filepath: string): boolean;
begin
  fHandle := Windows.LoadLibraryA(pAnsiChar(UTF8Encode(filepath)));
  Result := not (fHandle=null);
end;

{$endif}
end.
