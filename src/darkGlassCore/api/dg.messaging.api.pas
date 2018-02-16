unit dg.messaging.api;

interface
uses
  dg.messaging.api.types;

function SendMessage( aMessage: TMessage ): boolean; {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif} export;

implementation

function SendMessage( aMessage: TMessage ): boolean;
begin
  Result := False;
end;

exports
  SendMessage;

end.
