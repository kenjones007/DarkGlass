//------------------------------------------------------------------------------
// This file is part of the DarkGlass game engine project.
// More information can be found here: http://chapmanworld.com/darkglass
//
// DarkGlass is licensed under the MIT License:
//
// Copyright 2018 Craig Chapman
//
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the “Software”),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
// DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
// OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
// USE OR OTHER DEALINGS IN THE SOFTWARE.
//------------------------------------------------------------------------------
unit dg.platform.mainloop.windows;

interface
uses
  system.generics.collections,
  dg.messaging.messagechannel,
  dg.messaging.messagebus,
  dg.platform.window,
  dg.threading.subsystem;

type
  TMainLoop = class( TInterfacedObject, ISubSystem )
  private
    fMessageChannel: IMessageChannel;
    fMainWindow: IWindow;
//    fWindows: TList<IWindow>;
  private //- ISubSystem
    procedure Install( MessageBus: IMessageBus );
    function Initialize( MessageBus: IMessageBus ): boolean;
    function Execute: boolean;
    procedure Finalize;
  end;

implementation
uses
  darkglass.types,
  dg.platform.window.windows,
  Windows,
  Messages;

function TMainLoop.Execute: boolean;
var
  aMessage: tagMsg;
  anotherMessage: darkglass.types.TMessage;
begin
  Result := True;
  //- Check for OS messages
  if Windows.PeekMessage(aMessage,0,0,0,PM_REMOVE) then begin
     TranslateMessage(aMessage);
     DispatchMessage(aMessage);
     if aMessage.message=WM_QUIT then begin
       Result := False;
     end;
  end;
  //- Check for engine messages
  if not fMessageChannel.Pull(anotherMessage) then begin
    exit;
  end;
  case anotherMessage.MessageValue of
    0: begin
      fMainWindow := TWindow.Create;
    end;
  end;
end;

procedure TMainLoop.Finalize;
begin
  //- Do nothing
end;

function TMainLoop.Initialize(MessageBus: IMessageBus): boolean;
begin
  Result := True;
end;

procedure TMainLoop.Install(MessageBus: IMessageBus);
begin
  fMessageChannel := MessageBus.CreateMessageChannel('platform');
end;

end.
