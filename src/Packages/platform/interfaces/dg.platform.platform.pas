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
  ///  <summary>
  ///    A message handling procedure for responding to messages on the game
  ///    channel.
  ///  </summary>
  TMessageHandler = function( MessageValue: uint32; var ParamA: NativeUInt; var ParamB: NativeUInt ): boolean;

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

    ///  <summary>
    ///    Gets a connection to a message channel and returns a handle to it.
    ///    If the handle returned is non-zero, then this is a valid handle.
    ///  </summary>
    function GetChannelConnection( ChannelName: string ): THChannelConnection;

    /// <summary>
    /// </summary>
    function SendMessage( ConnectionHandle: THChannelConnection; MessageValue: uint32; ParamA: NativeUInt; ParamB: NativeUInt; WaitFor: Boolean = False  ): TMessageResponse;

    /// <summary>
    ///   Initializes the worker threads, sub-systems, and communication
    ///   channels of the application.
    /// </summary>
    /// <returns>
    ///   Returns true if the application was successfully started. <br />Will
    ///   return false if the application fails to start for any reason (which
    ///   may also be accompanied by an exception).
    /// </returns>
    function Initialize( GameMessageHandler: TMessageHandler ): boolean;

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
