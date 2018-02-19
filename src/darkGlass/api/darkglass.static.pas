unit darkglass.static;

interface

implementation
uses
  dg.engine.api,
  dg.messaging.api,
  darkglass;

initialization
//SendMessage := @dg.messaging.api.SendMessage;
  dgVersionMajor := @dg.engine.api.dgVersionMajor;
  dgVersionMinor := @dg.engine.api.dgVersionMinor;
    dgInitialize := @dg.engine.api.dgInitialize;
           dgRun := @dg.engine.api.dgRun;
      dgFinalize := @dg.engine.api.dgFinalize;
end.
