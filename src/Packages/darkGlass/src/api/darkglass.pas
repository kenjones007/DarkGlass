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

const
  cMaxStringLength = 255;

type
  ///  <summary>
  ///    Used as a handle to objects passed through the messaging system
  ///    to the darkglass engine.
  ///  </summary>
  THandle = pointer;

  ///  <summary>
  ///    Used to send messages into the darkglass message bus.
  ///  </summary>
  TMessage = record
    Value: nativeuint;
    ParamA: nativeuint;
    ParamB: nativeuint;
    ParamC: nativeuint;
    ParamD: nativeuint;
  end;

  ///  <summary>
  ///    The callback prototype, used as a callback function for the main
  ///    application while the dark glass engine is running.
  ///  </summary>
  TExternalMessageHandler = function (aMessage: TMessage): nativeuint;

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
  ///    You must call dgInitialize() before calling dgRun().
  ///  </summary>
  dgInitialize: procedure( MessageHandler: TExternalMessageHandler ); {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif}

  ///
  ///  <summary>
  ///    Finalizes the DarkGlass engine.
  ///    You must call dgFinalize() after calling dgRun().
  ///  </summary>
  dgFinalize: procedure; {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif}

  /// <summary>
  ///   This procedure passes execution to the run method of the global IPlatform
  ///   instance, which subsequently passes execution to the application main
  ///   loop. This procedure will therefore not return until execution of the
  ///   application has ended.
  /// </summary>
  dgRun: procedure; {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif}

  ///  <summary>
  ///    This function returns a handle to a commincation channel, allowing
  ///    messages to be sent into the communication channel.
  ///    The channel name is a UTF-8 (ANSI) string terminated with a zero character.
  ///    The channel name must not exceed cMaxChannelName characters.
  ///  </summary>
  dgGetMessagePipe: function ( lpszChannelName: pointer ): THandle; {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif}

  ///  <summary>
  ///    Sends a message into the specified message pipe.
  ///    This function immediately returns without waiting for a response from
  ///    the message channel. If the message cannot be sent, this function returns
  ///    false, else it returns true on successful transmission of the message.
  ///  </summary>
  dgSendMessage: function ( PipeHandle: THandle; MessageValue, ParamA, ParamB, ParamC, ParamD: nativeuint ): boolean;  {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif}

  ///  <summary>
  ///    Sends a message into the specified message pipe.
  ///    This function will wait for a response from the message channel.
  ///  </summary>
  dgSendMessageWait: function( PipeHandle: THandle; MessageValue, ParamA, ParamB, ParamC, ParamD: nativeuint ): nativeuint;  {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif}

  ///  <summary>
  ///    This procedure frees a handle to an object within the system.
  ///  </summary>
  dgFreeHandle: procedure( Handle: THandle ); {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif}



implementation

end.
