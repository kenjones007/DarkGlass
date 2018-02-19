unit darkglass.dynlib.posix;

interface
uses
  darkglass.dynlib;

type
  TDynLib = class( TInterfacedObject, IDynLib )
  private
    function LoadLibrary( filepath: string ): boolean;
    function FreeLibrary: boolean;
    function GetProcAddress( funcName: string ): pointer;
  end;

implementation

{ TDynLib }

function TDynLib.FreeLibrary: boolean;
begin

end;

function TDynLib.GetProcAddress( funcName: string ): pointer;
begin

end;

function TDynLib.LoadLibrary(filepath: string): boolean;
begin

end;

end.
