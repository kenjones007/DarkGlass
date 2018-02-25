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
unit dg.messaging.messagepipe;

interface
uses
  darkglass.types;

type

  /// <summary>
  ///   An implementation of IMessagePipe provides a thread-safe unidirectional
  ///   mechanism for sending messages between two threads. Each pipe may have
  ///   a single originator thread and a single target thread, and messages
  ///   flow from the originator to the target.
  /// </summary>
  /// <remarks>
  ///   The DarkGlass engine provides IMessageChannel and IMessageBus to
  ///   aggregate multiple pipes, allowing for bidirectional communication
  ///   among multiple originators and targets. The IMessagePipe is the
  ///   lowest-level primitive of this communications system, providing
  ///   lock-less communication between a single originator and a single target
  ///   which may exist on different execution threads.
  /// </remarks>
  IMessagePipe = interface
    ['{B8FE0D89-B21F-4352-B7FE-F96A335F6EBE}']


    /// <summary>
    ///   The originator inserts messages into the pipe by calling the Push()
    ///   method.
    /// </summary>
    /// <param name="aMessage">
    ///   A TMessage structure containing the message information to be sent to
    ///   the target.
    /// </param>
    /// <returns>
    ///   Returns true if the message is successfully inserted into the pipe
    ///   (does not indicate that the message is retrieved from the pipe by the
    ///   target). If this method returns false, it is likely that the pipe is
    ///   full, and a re-try later may be successful.
    /// </returns>
    function Push( aMessage: TMessage ): boolean;


    /// <summary>
    ///   The Pull() method is polled by the message target, and retreieves
    ///   messages from the pipe which were previously inserted by the
    ///   originator calling the Push() method.
    /// </summary>
    /// <param name="aMessage">
    ///   A TMessage structure to be populated with a message from the pipe.
    /// </param>
    /// <returns>
    ///   If there is a message in the pipe to be returned, the aMessage
    ///   parameter is populated and this method returns true. Otherwise, if
    ///   the pipe is empty, this method returns false.
    /// </returns>
    function Pull( var aMessage: TMessage ): boolean;
  end;

implementation

end.
