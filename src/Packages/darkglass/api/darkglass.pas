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
unit darkglass;

interface


type
  ///  <summary>
  ///    A handle representing a message channel.
  ///  </summary>
  THMessageChannel = uint32;

  ///  <summary>
  ///    A record type representing a communication message between
  ///    subsystems.
  ///  </summary>
  TMessage = record
    MessageValue: uint32;
    ParamA: NativeUInt;
    ParamB: NativeUInt;
  end;

var
  /// <summary>
  ///   Returns the major part of the library version number. For example, if the
  ///   version number is 2.5 this function returns 2.
  /// </summary>
  /// <returns>
  ///   See description.
  /// </returns>
  dgVersionMajor: function: uint32; {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif}

  /// <summary>
  ///   Returns the minor part of the library version number. For example, if the
  ///   version number is 2.5 this function returns 5.
  /// </summary>
  /// <returns>
  ///   See description.
  /// </returns>
  dgVersionMinor: function: uint32; {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif}

  ///  <summary>
  ///    Initializes the DarkGlass engine.
  ///    You must call dgInitialize() before calling dgRun(),
  ///    dgGetMessageChannel(), or dgSendMessage(). (Or other messaging functions)
  ///  </summary>
  dgInitialize: procedure; {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif}

  /// <summary>
  ///   This procedure passes execution to the run method of the global IPlatform
  ///   instance, which subsequently passes execution to the application main
  ///   loop. This procedure will therefore not return until execution of the
  ///   application has ended.
  /// </summary>
  dgRun: procedure(); {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif}

  /// <summary>
  ///   This function locates a message channel by name and returns a handle to
  ///   it. <br />Message channels are used to communicate between the
  ///   sub-systems of the application during execution.
  /// </summary>
  /// <param name="ChannelName">
  ///   The case-insensitive name of the message channel to be located.
  /// </param>
  /// <returns>
  ///   If this method is unsuccessful a value of zero is returned, otherwise a
  ///   handle to the message channel is returned.
  /// </returns>
  dgGetMessageChannel: function( ChannelName: string ): THMessageChannel; {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif}

  /// <summary>
  ///   This procedure sends a message into a message channel as specified by
  ///   it's handle (optained using the dggetMessageChannal() function.
  /// </summary>
  /// <param name="Channel">
  ///   The handle of a message channel to send a message to.
  /// </param>
  /// <param name="aMessage">
  ///   The message to send into the message channel.
  /// </param>
  /// <returns>
  ///   Returns true if the message was sent to the channel, else returns false. <br />
  ///   Possible causes of failure include the message channel being full, or an
  ///   invalid message channel handle being specified.
  /// </returns>
  dgSendMessage: function( Channel: THMessageChannel; aMessage: TMessage ): boolean;  {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif}

implementation

end.
