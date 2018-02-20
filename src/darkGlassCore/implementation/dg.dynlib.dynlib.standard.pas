unit dg.dynlib.dynlib.standard;

interface
uses
{$ifdef MSWINDOWS}
  dg.dynlib.dynlib.windows;
{$else}
  dg.dynlib.dynlib.posix;
{$endif}

type
  {$ifdef MSWINDOWS}
  TDynLib = dg.dynlib.dynlib.windows.TDynLib;
  {$else}
  TDynLib = dg.dynlib.dynlib.posix.TDynLib;
  {$endif}

implementation

end.
