unit darkglass;

interface
uses
  dg.messaging.api,
  dg.messaging.api.types;

type
  TMessage = dg.messaging.api.types.TMessage;

var
  dgVersionMajor: function: uint32;
  dgVersionMinor: function: uint32;
  dgInitialize: function : boolean;
  dgRun: procedure();
  dgFinalize: function: boolean;

implementation

end.
