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
unit dg.dynlib.dynlib.posix;

interface
uses
  dg.dynlib.dynlib;

type
  TDynLib = class( TInterfacedObject, IDynLib )
  private
    fHandle: pointer;
  private
    function LoadLibrary( filepath: string ): boolean;
    function FreeLibrary: boolean;
    function GetProcAddress( funcName: string ): pointer;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation

const
  clibname = 'libdl.so';
  cSuccess = 0;
  cRTLD_LAZY = 1;

function dlopen( filename: pointer; flags: int32 ): pointer; cdecl; external clibname name 'dlopen';
function dlsym( handle: pointer; symbolname: pointer ): pointer; cdecl; external clibname name 'dlsym';
function dlclose( handle: pointer ): int32; cdecl; external clibname name 'dlclose';

{ TDynLib }

constructor TDynLib.Create;
begin
  inherited Create;
  fHandle := nil;
end;

destructor TDynLib.Destroy;
begin
  if fHandle<>nil then begin
    FreeLibrary;
  end;
  inherited Destroy;
end;

function TDynLib.FreeLibrary: boolean;
begin
  Result := False;
  if fHandle=nil then begin
    Result := True;
    exit;
  end;
  Result := dlClose(fHandle) = cSuccess;
end;

function TDynLib.GetProcAddress( funcName: string ): pointer;
begin
  Result := nil;
  if fHandle=nil then begin
    exit;
  end;
  Result := dlSym( fHandle, pointer(UTF8Encode(funcname)) );
end;

function TDynLib.LoadLibrary(filepath: string): boolean;
begin
  Result := False;
  if fHandle<>nil then begin
    exit;
  end;
  fHandle := dlOpen(pointer(UTF8Encode(filepath)),cRTLD_LAZY);
  Result := fHandle<>nil;
end;

end.
