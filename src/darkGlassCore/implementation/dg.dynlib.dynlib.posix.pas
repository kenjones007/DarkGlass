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
