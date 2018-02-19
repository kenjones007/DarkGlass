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
