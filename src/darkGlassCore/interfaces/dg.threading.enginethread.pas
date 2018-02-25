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
unit dg.threading.enginethread;

interface
uses
  dg.messaging.messagebus,
  dg.threading.subsystem;

type

  /// <summary>
  ///   Represents an executing thread to be installed into the thread engine
  ///   (IThreadEngine).
  /// </summary>
  IEngineThread = interface
  ['{13CE71F7-C2AD-4B7B-AEC1-2A89FC2310A8}']

    /// <summary>
    ///   Adds a subsystem to the thread. This method will only function before
    ///   the thread is started.
    /// </summary>
    /// <param name="aSubSystem">
    ///   Pass a reference to the sub-system to be installed into the thread.
    ///   The sub-system will share execution time with other installed
    ///   sub-systems.
    /// </param>
    procedure InstallSubsystem( aSubSystem: ISubSystem );

    /// <summary>
    ///   Starts the thread running.
    /// </summary>
    procedure Start;
  end;

implementation

end.
