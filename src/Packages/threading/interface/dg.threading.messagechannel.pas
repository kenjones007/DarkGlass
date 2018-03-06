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
unit dg.threading.messagechannel;

interface
uses
  dg.threading.types,
  dg.threading.messagepipe;

type

  /// <summary>
  ///   An implementation of IMessageChannel provides a named mechanism for
  ///   delivering messages to a sub-system. A message channel is a collection
  ///   of message pipes, where each message pipe facilitates communication
  ///   between one originator sub-system, and the target subsystem which owns
  ///   the channel.
  /// </summary>
  /// <remarks>
  ///   As an abstract example, there may be a sub-system responsible for
  ///   playing audio files, which owns a message channel named 'audio'. Every
  ///   sub-system which wishes to send messages to the audio sub-system, must
  ///   acquire a pipe from the 'audio' channel, and may then send messages
  ///   into that pipe, for the audio sub-system to receive.
  /// </remarks>
  IMessageChannel = interface
    ['{E72DE502-E6B9-49B9-829C-964587A555D4}']

    ///  <summary>
    ///    Returns the name of this message channel.
    ///  </summary>
    function getName: string;

    /// <summary>
    ///   Pulls a message from the pipes of the message channel. Returns true
    ///   if a message is returned, else returns false. This method is called
    ///   by the target sub-system, which owns the message channel.
    /// </summary>
    /// <param name="aMessage">
    ///   A TMessage structure which will be populated with the message which
    ///   is retrieved from the channel.
    /// </param>
    /// <returns>
    ///   If a message is waiting to be received, this method will populate its
    ///   aMessage parameter and return true. If there are no messages waiting
    ///   to be retrieved, this method will simply return false.
    /// </returns>
    function Pull( var aMessage: TMessage; WaitFor: boolean = False ): boolean;

    /// <summary>
    ///    Pushes a message into the message channel using the pipe associated
    ///    with the message originator thread.
    /// </summary>
    function Push( Pipe: IMessagePipe; aMessage: TMessage ): boolean;

    /// <summary>
    ///   Returns a handle to a message pipe, which the calling thread may
    ///   use to inject messages into this channel.
    /// </summary>
    /// <returns>
    ///   Returns a handle to the message pipe.
    /// </returns>
    /// <remarks>
    ///   Each originating sub-system must call this method to obtain it's own
    ///   dedicated message pipe handle for this channel. Pipes are only
    //    thread-safe between two threads, the originator and the target,
    //    they may not be shared between multiple originators.
    /// </remarks>
    function getPipe: IMessagePipe;

    // - Pascal Only, Property -//

    ///  <summary>
    ///    Returns the name of this message channel.
    ///  </summary>
    property Name: string read getName;
  end;

implementation

end.
