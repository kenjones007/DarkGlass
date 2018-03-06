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
unit dg.threading.subsystem;

interface
uses
  dg.threading.messagebus;

type

  /// <summary>
  ///   Implement the ISubSystem interface to provide functionality to be
  ///   executed by the threading system. <br /><br />ISubSystem represents a
  ///   sub-system executing within a thread. Sub-systems operate
  ///   cooperatively, in that the thread will call their execute method
  ///   repeatedly for the life of the thread, and the execute method is
  ///   expected to return execution to the thread. An implementation of
  ///   ISubSystem should not enter long running loops within it's Execute
  ///   method.
  /// </summary>
  ISubSystem = interface
  ['{37CF5CD7-EB5E-4FD5-A46B-A123EFC71870}']


    /// <summary>
    ///   The Install method is called by it's executing thread as the
    ///   sub-system is installed into that thread. A reference to the message
    ///   bus is provided so that the sub-system can create any message
    ///   channels it requires. *Note, this is an opportunity to create new
    ///   message channels for the sub-system, but is too early to acquire
    ///   pipes to other sub-systems. Acquiring pipes should be done within the
    ///   implementtion of the Initialize method.
    /// </summary>
    /// <param name="MessageBus">
    ///   A reference to the global message bus, through which sub-systems
    ///   communicate.
    /// </param>
    procedure Install;

    /// <summary>
    ///   The initialize method is called by the execution thread immediately
    ///   before the thread begins calling the execute method of the
    ///   sub-system. This is an opportunity for the sub-system to allocate
    ///   memory and acquire message pipes to communicate with other
    ///   sub-systems. Note* References to any message pipes acquired here
    ///   should be retained for use during execution, there is no later
    ///   opporunity to acquire new message pipes (this would violate the
    ///   thread-safety of the messaging system, which is lose to enable
    ///   lock-less threading).
    /// </summary>
    function Initialize: boolean;

    /// <summary>
    ///   The execute() method will be called repeatedly by the execution
    ///   thread into which this sub-system is installed. The execute method is
    ///   expected to return execution as quickly as possible, as it
    ///   co-operates in a round-robin with other sub-systems installed into
    ///   the same thread.
    /// </summary>
    /// <returns>
    ///   The execute method should return true so long as it needs to continue
    ///   running. When the execute method returns false, the executing thread
    ///   will uninstall and finalize the sub-system.
    /// </returns>
    function Execute: boolean;


    /// <summary>
    ///   The finalize method is called by the execute thread as the sub-system
    ///   is uninstalled from the thread. This is an opportunity for the
    ///   sub-system to free up resources that were allocated during it's
    ///   initialization or execution.
    /// </summary>
    procedure Finalize;
  end;


implementation

end.
