program DarknessDebug;
uses
//  darkglass.static,
  darkglass.dynamic,
  sysutils,
  System.StartUpCopy;

var
  Engine: TDarkglassEngine;
  aMessage: TMessage;

begin
  Engine := getDarkGlass;
  if not Engine.SendMessage(aMessage) then begin
    Sleep(1);
  end;
end.
