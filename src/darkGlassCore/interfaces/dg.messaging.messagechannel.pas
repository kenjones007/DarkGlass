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
unit dg.messaging.messagechannel;

interface
uses
  darkglass.types,
  dg.messaging.messagepipe;

type
  IMessageChannel = interface
    ['{E72DE502-E6B9-49B9-829C-964587A555D4}']

    ///  <summary>
    ///    Returns the name of this message channel.
    ///  </summary>
    function getName: string;

    ///  <summary>
    ///    Pulls a message from the pipes of the message channel.
    ///    Returns true if a message is returned, else returns false.
    ///  </summary>
    function Pull( var aMessage: TMessage ): boolean;

    ///  <summary>
    ///    Returns an implementation of IMessagePipe, which may be used
    ///    to inject messages into this channel.
    ///  </summary>
    function getPipe: IMessagePipe;

    // - Pascal Only, Property -//
    property Name: string read getName;
  end;

implementation

end.
