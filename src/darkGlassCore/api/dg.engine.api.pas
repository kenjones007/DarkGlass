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
unit dg.engine.api;

interface

function dgVersionMajor: uint32;  {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif} export;
function dgVersionMinor: uint32;  {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif} export;
function dgInitialize: boolean;   {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif} export;
procedure dgRun;                  {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif} export;
function dgFinalize: boolean;     {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif} export;

implementation
uses
  sysutils;

const
  cVersionMajor = 1;
  cVersionMinor = 0;

function dgVersionMajor: uint32;
begin
  Result := cVersionMajor;
end;

function dgVersionMinor: uint32;
begin
  Result := cVersionMinor;
end;

function dgInitialize: boolean;
begin
  Result := True;
end;

procedure dgRun;
begin
  while (True) do begin
    Sleep(1);
  end;
end;

function dgFinalize: boolean;
begin
  Result := True;
end;

exports
  dgVersionMajor,
  dgVersionMinor,
  dgInitialize,
  dgRun,
  dgFinalize;

end.
