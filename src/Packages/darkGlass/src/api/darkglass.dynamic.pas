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
unit darkglass.dynamic;

interface

implementation
uses
  sysutils,
  darkDynlib,
  darkglass;

const
{$ifdef MSWINDOWS}
  cLibName = 'darkglass.core.dll';
{$endif}
{$ifdef MACOS}
  {$ifdef IOS}
  cLibName = 'libdarkglass.core.dynlib';
  {$else}
  cLibName = 'libdarkglass.core..dynlib';
  {$endif}
{$endif}
{$ifdef ANDROID}
  cLibName = 'libdarkglass.core..so';
{$endif}
{$ifdef LINUX}
  cLibName = 'libdarkglass.core.so';
{$endif}


var
  libDarkGlass: IDynLib = nil;

function LoadProcAddress( funcname: string ): pointer;
begin
  Result := libDarkGlass.GetProcAddress(funcname);
  if not assigned(Result) then begin
    raise
      Exception.Create('Could not bind to function: '+funcname+' in libDakglass');
  end;
end;

initialization
  libDarkGlass := TDynLib.Create;
  if not libDarkGlass.LoadLibrary(cLibName) then begin
    raise
      Exception.Create('Cannot find librarby '''+cLibName+'''.');
  end;

                 dgVersionMajor := LoadProcAddress('dgVersionMajor');
                 dgVersionMinor := LoadProcAddress('dgVersionMinor');
                          dgRun := LoadProcAddress('dgRun');
  dgGetMessageChannelConnection := LoadProcAddress('dgGetMessageChannelConnection');
                  dgSendMessage := LoadProcAddress('dgSendMessage');
                   dgInitialize := LoadProcAddress('dgInitialize');

finalization
  libDarkGlass := nil;

end.
