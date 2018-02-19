unit darkglass.dynlib.standard;

interface
uses
{$ifdef MSWINDOWS}
  darkglass.dynlib.windows;
{$else}
  darkglass.dynlib.posix;
{$endif}

type
  {$ifdef MSWINDOWS}
  TDynLib = darkglass.dynlib.windows.TDynLib;
  {$else}
  TDynLib = darkglass.dynlib.posix.TDynLib;
  {$endif}

implementation

end.
