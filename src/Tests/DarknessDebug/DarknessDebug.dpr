program DarknessDebug;
uses
  darkglass,
//  darkglass.static,
  darkglass.dynamic,
  sysutils,
  System.StartUpCopy;

var
  aMessage: TMessage;

begin
  if not dgInitialize() then begin
    halt(1);
  end;
  try
    dgRun();
  finally
    dgFinalize();
  end;
end.
