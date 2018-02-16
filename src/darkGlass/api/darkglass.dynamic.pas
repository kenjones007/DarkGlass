unit darkglass.dynamic;

interface
uses
  darkglass.common,
  dg.messaging.api.types;

type
  TMessage = dg.messaging.api.types.TMessage;
  TDarkglassEngine =  darkglass.common.TDarkglassEngine;

function getDarkGlass: TDarkGlassEngine;

implementation

function InternalSendMessage( aMessage: TMessage ): boolean; stdcall; external 'DarkGlassCore.dll' name 'SendMessage';

function getDarkGlass: TDarkGlassEngine;
begin
  Result.SendMessage := @InternalSendMessage;
end;

end.
