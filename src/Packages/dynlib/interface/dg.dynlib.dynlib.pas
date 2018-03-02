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
unit dg.dynlib.dynlib;

interface

type

  /// <summary>
  ///   An instance of IDynlib represents a dynamic library, such as a .dll or
  ///   .so file.
  /// </summary>
  IDynlib = interface
    ['{AA731CC2-8779-4F83-8117-F481DDD2B48D}']

    /// <summary>
    ///   Loads a library from disk into memory.
    /// </summary>
    /// <param name="filepath">
    ///   Specifies the full path and filename of the library to be loaded.
    ///   (Relative paths permitted based on target implementation).
    /// </param>
    /// <returns>
    ///   Returns false if the library could not be loaded for any reason. May
    ///   also return false if the instance of IDynLib has already loaded a
    ///   library. Otherwise returns true.
    /// </returns>
    function LoadLibrary( filepath: string ): boolean;

    /// <summary>
    ///   Unloads the library (previously loaded using the LoadLibrary()
    ///   method) from memory.
    /// </summary>
    /// <returns>
    ///   Returns false if the library failed to unload for any reason, or if
    ///   the LoadLibrary() method was not previously called. Otherwise returns
    ///   true.
    /// </returns>
    function FreeLibrary: boolean;

    /// <summary>
    ///   Locates a symbol within a library (previously loaded using the
    ///   LoadLibrary() method), and returns a pointer to it.
    /// </summary>
    /// <param name="funcName">
    ///   The name of the function or symbol to locate.
    /// </param>
    /// <returns>
    ///   If successful, returns a pointer to the requested symbol. Otherwise
    ///   returns false. Typically a failure is caused either by not having
    ///   first loaded the library using the LoadLibrary() method, or because
    ///   of an incorrect symbol name specified in the funcName parameter.
    ///   Symbol names may be case sensitive, depending upon the implementation
    ///   and target.
    /// </returns>
    function GetProcAddress( funcName: string ): pointer;
  end;

implementation

end.
