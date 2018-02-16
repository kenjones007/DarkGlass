unit darkglass.common;

interface
uses
  dg.messaging.api,
  dg.messaging.api.types;

type
  TDarkglassEngine = record
    SendMessage: function ( aMessage: TMessage ): boolean;
  end;

implementation

end.
