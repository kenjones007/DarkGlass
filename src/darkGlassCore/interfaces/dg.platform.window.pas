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
unit dg.platform.window;

interface

type

  /// <summary>
  ///   Represents a window within the target platforms UI system. This may be
  ///   a visible window on a desktop, or an abstract window concept such as a
  ///   rendering surface on mobile targets.
  /// </summary>
  IWindow = interface
    ['{87174835-FEAA-4ED1-8E5B-94F3D7C3654E}']

    /// <summary>
    ///   Returns a pointer to the OS-level window handle. <br />Except on
    ///   target platforms where a window handle is a pointer type, in which
    ///   case this method returns that pointer.
    /// </summary>
    /// <returns>
    ///   The OS-Level window handle, or a pointer to it. (Platform specific
    ///   behavior).
    /// </returns>
    function getHandle: pointer;
  end;

implementation

end.
