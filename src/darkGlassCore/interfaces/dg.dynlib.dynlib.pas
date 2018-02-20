unit dg.dynlib.dynlib;

interface

type
  IDynlib = interface
    ['{AA731CC2-8779-4F83-8117-F481DDD2B48D}']
    function LoadLibrary( filepath: string ): boolean;
    function FreeLibrary: boolean;
    function GetProcAddress( funcName: string ): pointer;
  end;

implementation

end.
