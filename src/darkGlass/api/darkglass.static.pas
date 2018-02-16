unit darkglass.static;

interface
uses
  darkglass.common,
  dg.messaging.api,
  dg.messaging.api.types;


type
  TMessage = dg.messaging.api.types.TMessage;
  TDarkglassEngine = darkglass.common.TDarkglassEngine;

function getDarkGlass: TDarkGlassEngine;

implementation

function getDarkGlass: TDarkGlassEngine;
begin
  Result.SendMessage := @dg.messaging.api.SendMessage;
end;

end.
