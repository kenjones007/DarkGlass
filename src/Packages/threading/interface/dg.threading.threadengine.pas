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
unit dg.threading.threadengine;

interface
uses
  dg.threading.messagebus,
  dg.threading.enginethread;

type

  /// <summary>
  ///   IThreadEngine represents a collection of execution threads, including
  ///   the main thread, each of which host sub-systems for long running
  ///   operations. The ThreadEngine also provides access to the cross-thread
  ///   messaging system which allows sub-systems to communicate with each
  ///   other.
  /// </summary>
  IThreadEngine = interface
    ['{30780107-FED7-4A3B-BF80-742FDE3A8620}']

    /// <summary>
    ///   Returns the number of execution threads operating within the thread
    ///   engine, including the main application thread, which is always at
    ///   index zero.
    /// </summary>
    function getThreadCount: uint32;

    /// <summary>
    ///   Returns a reference to the class which represents the execution
    ///   thread, as specified by index.
    /// </summary>
    /// <param name="idx">
    ///   The index of the thread to be returned.
    /// </param>
    /// <returns>
    ///   If the index reflects a valid thread, a reference to the class
    ///   representing that thread is returned, otherwise nil is returned.
    /// </returns>
    /// <remarks>
    ///   Index zero always represents the main application thread.
    /// </remarks>
    function getThread( idx: uint32 ): IEngineThread;


    /// <summary>
    ///   The run method starts all of the execution threads running, including
    ///   the main thread. <br />The main thread is started after the others,
    ///   and retains execution until all of it's sub-systems have shut down,
    ///   at which time it will shut down all other threads and return from
    ///   this method.
    /// </summary>
    procedure Run;

    //- Pascal Only, Properties -//

    /// <summary>
    ///   Returns the number of execution threads operating within the thread
    ///   engine, including the main application thread, which is always at
    ///   index zero.
    /// </summary>
    property Count: uint32 read getThreadCount;

    /// <summary>
    ///   Returns a reference to the class which represents the execution
    ///   thread, as specified by index. <br />(Provides array-style access for
    ///   convenience.)
    /// </summary>
    /// <param name="idx">
    ///   The index of the thread to be returned.
    /// </param>
    /// <returns>
    ///   If the index reflects a valid thread, a reference to the class
    ///   representing that thread is returned, otherwise nil is returned.
    /// </returns>
    /// <remarks>
    ///   Index zero always represents the main application thread.
    /// </remarks>
    property Threads[ idx: uint32 ]: IEngineThread read getThread;

  end;

implementation

end.
