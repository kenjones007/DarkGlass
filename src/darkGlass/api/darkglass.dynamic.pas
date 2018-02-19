unit darkglass.dynamic;

interface

implementation
uses
  sysutils,
  darkglass.dynlib,
  darkglass.dynlib.standard,
  darkglass;

const
{$ifdef MSWINDOWS}
  cLibName = 'DarkGlassCore.dll';
{$endif}
{$ifdef MACOS}
  {$ifdef IOS}
  cLibName = 'libDarkglass.dynlib';
  {$else}
  cLibName = 'libDarkglass.dynlib';
  {$endif}
{$endif}
{$ifdef ANDROID}
  cLibName = 'libDarkglass.so';
{$endif}
{$ifdef LINUX}
  cLibName = 'libDarkglass.so';
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
    dgInitialize := LoadProcAddress('dgInitialize');
           dgRun := LoadProcAddress('dgRun');
      dgFinalize := LoadProcAddress('dgFinalize');

finalization
  libDarkGlass := nil;


end.
