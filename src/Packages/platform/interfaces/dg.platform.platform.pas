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
unit dg.platform.platform;

interface
uses
  dg.threading;

type
  /// <summary>
  ///   An implementation of IPlatform represents, through abstraction, the
  ///   available capabilities of the target platform.
  /// </summary>
  /// <remarks>
  ///   Applications within the DarkGlass engine are divided into sub-systems,
  ///   which operate across multiple CPU cores and threads. Communication
  ///   between these sub-systems is enabled using the concept of 'message
  ///   channels', where a channel is a collection of 'message pipes'. An
  ///   implementation of IPlatform initializes and provides access to
  ///   sub-systems and message channels, and provides a sub-system to
  ///   encompass the application main loop.
  /// </remarks>
  IPlatform = interface
    ['{96483AB0-2942-4D7B-9E9D-1473CA32D6CB}']

    /// <summary>
    ///   Locates a message channel by name, and returns a handle to it. <br />
    ///   If the named channel does not yet exist, it will be created.
    /// </summary>
    /// <param name="ChannelName">
    ///   The case-insensitive name of a message channel to locate.
    /// </param>
    /// <returns>
    ///   If successful, returns a handle to the message channel. If
    ///   unsuccessful, returns a null handle (zero value).
    /// </returns>
    function GetMessageChannel( ChannelName: string ): THMessageChannel;

    /// <summary>
    ///   Sends a message to the communication channel, specified by handle.
    ///   Where the handle is obtained by calling the GetMessageChannel()
    ///   method. <br /><br />SendMessage() is asynchonous, in-that, a message
    ///   will be sent into the message channel and then the SendMessage() will
    ///   return, regardless of the message having been handled by the
    ///   receiving sub-system.
    /// </summary>
    /// <param name="Channel">
    ///   A handle for the message channel, obtained through the
    ///   GetMessageChannel() method.
    /// </param>
    /// <param name="aMessage">
    ///   A TMessage structure, populated with the message information to be
    ///   transmitted into the channel.
    /// </param>
    /// <returns>
    ///   Returns true if the message is successfully sent on the message
    ///   channel (this does not indicate successfully received or handled by
    ///   the receiving sub-system). Returns false if the message could not be
    ///   sent - one possible cause of a failure is the message channel becomes
    ///   full.
    /// </returns>
    function SendMessage( Channel: THMessageChannel; aMessage: TMessage ): boolean;

    /// <summary>
    ///   Initializes the worker threads, sub-systems, and communication
    ///   channels of the application.
    /// </summary>
    /// <returns>
    ///   Returns true if the application was successfully started. <br />Will
    ///   return false if the application fails to start for any reason (which
    ///   may also be accompanied by an exception).
    /// </returns>
    function Initialize: boolean;

    /// <summary>
    ///   Starts the worker threads and sub-systems of the application, and
    ///   enters the application main loop. This method will not return until
    ///   the main loop has exited.
    /// </summary>
    procedure Run;

    /// <summary>
    ///   Stops the worker threads from running, then disposes of sub-systems,
    ///   worker threads, and communications channels.
    /// </summary>
    /// <returns>
    ///   Returns false if the sysetm is not correctly shut down for any
    ///   reason, this may also be accompanied by an exception.
    /// </returns>
    function Finalize: boolean;
  end;

implementation

end.
