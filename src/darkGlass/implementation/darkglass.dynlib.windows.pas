unit darkglass.dynlib.windows;

interface
uses
  Windows,
  darkglass.dynlib;

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

implementation

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

end.
