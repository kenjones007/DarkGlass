(*

Copyright 1985, 1986, 1987, 1991, 1998  The Open Group

Permission to use, copy, modify, distribute, and sell this software and its
documentation for any purpose is hereby granted without fee, provided that
the above copyright notice appear in all copies and that both that
copyright notice and this permission notice appear in supporting
documentation.

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
OPEN GROUP BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Except as contained in this notice, the name of The Open Group shall not be
used in advertising or otherwise to promote the sale, use or other dealings
in this Software without prior written authorization from The Open Group.

*/


/*
 *	Xlib.h - Header definition and support file for the C subroutine
 *	interface library (Xlib) to the X Window System Protocol (V11).
 *	Structures and symbols starting with "_" are private to the library.
 */
*)
unit dg.platform.linux.binding.xlib;

interface
uses
  dg.platform.linux.binding.x;

{------------------------------------------------------------------------------}
{                                    Constants                                 }
{------------------------------------------------------------------------------}
const
           XlibSpecificationRelease = 6;
                 X_HAVE_UTF8_STRING = 1;
                              xTrue = TRUE;  // -CC- Renamed 'xTrue' because 'True' is existing reserved word in pascal.
                             xFalse = FALSE;  // -CC- Renamed 'xFalse' because 'False' is existing reserved word in pascal.
                      QueuedAlready = 0;
                 QueuedAfterReading = 1;
                   QueuedAfterFlush = 2;
                  XNRequiredCharSet = 'requiredCharSet';
                 XNQueryOrientation = 'queryOrientation';
                     XNBaseFontName = 'baseFontName';
                      XNOMAutomatic = 'omAutomatic';
                   XNMissingCharSet = 'missingCharSet';
                    XNDefaultString = 'defaultString';
                      XNOrientation = 'orientation';
      XNDirectionalDependentDrawing = 'directionalDependentDrawing';
                XNContextualDrawing = 'contextualDrawing';
                         XNFontInfo = 'fontInfo';
                     XIMPreeditArea = $00001;
                XIMPreeditCallbacks = $00002;
                 XIMPreeditPosition = $00004;
                  XIMPreeditNothing = $00008;
                     XIMPreeditNone = $00010;
                      XIMStatusArea = $00100;
                 XIMStatusCallbacks = $00200;
                   XIMStatusNothing = $00400;
                      XIMStatusNone = $00800;
                     XNVaNestedList = 'XNVaNestedList';
                  XNQueryInputStyle = 'queryInputStyle';
                     XNClientWindow = 'clientWindow';
                       XNInputStyle = 'inputStyle';
                      XNFocusWindow = 'focusWindow';
                     XNResourceName = 'resourceName';
                    XNResourceClass = 'resourceClass';
                 XNGeometryCallback = 'geometryCallback';
                  XNDestroyCallback = 'destroyCallback';
                     XNFilterEvents = 'filterEvents';
             XNPreeditStartCallback = 'preeditStartCallback';
              XNPreeditDoneCallback = 'preeditDoneCallback';
              XNPreeditDrawCallback = 'preeditDrawCallback';
             XNPreeditCaretCallback = 'preeditCaretCallback';
       XNPreeditStateNotifyCallback = 'preeditStateNotifyCallback';
                XNPreeditAttributes = 'preeditAttributes';
              XNStatusStartCallback = 'statusStartCallback';
               XNStatusDoneCallback = 'statusDoneCallback';
               XNStatusDrawCallback = 'statusDrawCallback';
                 XNStatusAttributes = 'statusAttributes';
                             XNArea = 'area';
                       XNAreaNeeded = 'areaNeeded';
                     XNSpotLocation = 'spotLocation';
                         XNColormap = 'colorMap';
                      XNStdColormap = 'stdColorMap';
                       XNForeground = 'foreground';
                       XNBackground = 'background';
                 XNBackgroundPixmap = 'backgroundPixmap';
                          XNFontSet = 'fontSet';
                        XNLineSpace = 'lineSpace';
                           XNCursor = 'cursor';
                XNQueryIMValuesList = 'queryIMValuesList';
                XNQueryICValuesList = 'queryICValuesList';
                  XNVisiblePosition = 'visiblePosition';
                XNR6PreeditCallback = 'r6PreeditCallback';
         XNStringConversionCallback = 'stringConversionCallback';
                 XNStringConversion = 'stringConversion';
                       XNResetState = 'resetState';
                           XNHotKey = 'hotKey';
                      XNHotKeyState = 'hotKeyState';
                     XNPreeditState = 'preeditState';
            XNSeparatorofNestedList = 'separatorofNestedList';
                    XBufferOverflow = -1;
                        XLookupNone = 1;
                       XLookupChars = 2;
                      XLookupKeySym = 3;
                        XLookupBoth = 4;
                         XIMReverse = 1;
                       XIMUnderline = 1 shl 1;
                       XIMHighlight = 1 shl 2;
                         XIMPrimary = 1 shl 5;
                       XIMSecondary = 1 shl 6;
                        XIMTertiary = 1 shl 7;
                XIMVisibleToForward = 1 shl 8;
               XIMVisibleToBackword = 1 shl 9;
                 XIMVisibleToCenter = 1 shl 10;
                  XIMPreeditUnKnown = 0;
                   XIMPreeditEnable = 1;
                  XIMPreeditDisable = 1 shl 1;
                    XIMInitialState = 1;
                   XIMPreserveState = 1 shl 1;
        XIMStringConversionLeftEdge = $000000001;
      XIMStringConversionRightEdge  = $000000002;
        XIMStringConversionTopEdge  = $000000004;
      XIMStringConversionBottomEdge = $000000008;
      XIMStringConversionConcealed  = $000000010;
        XIMStringConversionWrapped  = $000000020;
          XIMStringConversionBuffer = $00001;
            XIMStringConversionLine = $00002;
            XIMStringConversionWord = $00003;
            XIMStringConversionChar = $00004;
    XIMStringConversionSubstitution = $00001;
       XIMStringConversionRetrieval = $00002;
                   XIMHotKeyStateON = $00001;
                  XIMHotKeyStateOFF = $00002;


type
   long = nativeint;
  ulong = nativeuint;
 pulong = ^ulong;

  XPointer = pointer;

  // #define Bool int
   XBool = longbool; // -CC- Renamed 'XBool' because 'Bool' is already defined in pascal.
  Status = int32;

  P_XExtData = ^_XExtData;
  FreePrivateCallback = function (extension: P_XExtData):int32; cdecl;
  _XExtData = record
          number: int32;               //* number returned by XRegisterExtension */
            next: ^_XExtData;          //* next item on list of data for structure */
     freeprivate: FreePrivateCallback; //* called to free private storage */
    private_data: XPointer;            //* data private to this extension. */
  end;
  XExtData = _XExtData;

  XExtCodes = record
      extension: int32; //* extension number */
   major_opcode: int32; //* major op-code assigned by server */
    first_event: int32; //* first event number for the extension */
    first_error: int32; //* first error number for the extension */
  end;

  XPixmapFormatValues = record
             depth: int32;
    bits_per_pixel: int32;
      scanline_pad: int32;
  end;

  pXGCValues = ^XGCValues;
  XGCValues = record
           _function: int32;  //* logical operation -CC- renamed to '_function' because 'function' is a pascal reserved word. -//
          plane_mask: ulong; //* plane mask */
          foreground: ulong; //* foreground pixel */
          background: ulong; //* background pixel */
          line_width: int32;  //* line width */
          line_style: int32;	//* LineSolid, LineOnOffDash, LineDoubleDash */
           cap_style: int32;  //* CapNotLast, CapButt, CapRound, CapProjecting */
          join_style: int32;  //* JoinMiter, JoinRound, JoinBevel */
          fill_style: int32;  //* FillSolid, FillTiled, FillStippled, FillOpaeueStippled */
           fill_rule: int32;  //* EvenOddRule, WindingRule */
            arc_mode: int32;  //* ArcChord, ArcPieSlice */
                tile: Pixmap; //* tile pixmap for tiling operations */
             stipple: Pixmap; //* stipple 1 plane pixmap for stipping */
         ts_x_origin: int32;	//* offset for tile or stipple operations */
         ts_y_origin: int32;
               _font: Font;	  //* default text font for text operations -CC- renamed to '-font' because 'font' matches datatype name in case-insensitive pascal -//
      subwindow_mode: int32;  //* ClipByChildren, IncludeInferiors */
	graphics_exposures: XBool;  //* boolean, should exposures be generated */
       clip_x_origin: int32;	//* origin for clipping */
       clip_y_origin: int32;
           clip_mask: Pixmap;	//* bitmap clipping; other calls for rects */
         dash_offset: int32;  //* patterned/dashed line information */
              dashes: byte;   // -CC- replaced 'char' type with 'byte'
  end;

  _XGC = record
    ext_data: ^XExtData;
    gid: GContext;
  end;
  GC = ^_XGC;

  Visual = record
     ext_data: ^XExtData; //* hook for extension to hang data */
    _visualid: VisualID;  //* visual id of this visual -CC- renamed '_visualid' because 'visualid' matches data-type in case insensitive pascal -//
      c_class: int32;     //* C++ class of screen (monochrome, etc.) -CC- Took C++ conditional branch because A) Object pascal & B) 'class' is a reserved word.
      //* mask values */
      red_mask: ulong;
    green_mask: ulong;
     blue_mask: ulong;
  bits_per_rgb: int32;	//* log base 2 of distinct color values */
   map_entries: int32; //* color map entries */
  end;

  Depth = record
       depth: int32;	 //* this depth (Z) of the depth */
    nvisuals: int32;	 //* number of Visual types at this depth */
     visuals: ^Visual; //* list of visuals possible at this depth */
  end;

  PXDisplay = ^_XDisplay;
  Screen = record
           ext_data: ^XExtData; //* hook for extension to hang data */
            display: PXDisplay; //* back pointer to display structure */
               root: Window;        //* Root window id. */
    //* width and height of screen */
              width: int32;
             height: int32;
    //* width and height of  in millimeters */
             mwidth: int32;
            mheight: int32;
            ndepths: int32;		    //* number of depths possible */
             depths: ^Depth;       //* list of allowable depths on the screen */
         root_depth: int32;    //* bits per pixel */
        root_visual: ^Visual; //* root visual */
         default_gc: GC;       //* GC for the root root visual */
               cmap: Colormap;       //* default color map */
    //* White and Black pixel values */
        white_pixel: ulong;
        black_pixel: ulong;
    //* max and min color maps */
           max_maps: int32;
           min_maps: int32;
      backing_store: int32;	//* Never, WhenMapped, Always */
        save_unders: XBool;
	  root_input_mask: long;	//* initial root input mask */
  end;

  ScreenFormat = record
        ext_data: ^XExtData; //* hook for extension to hang data */
           depth: int32;     //* depth of this image format */
	bits_per_pixel: int32;     //* bits/pixel at this depth */
    scanline_pad: int32;     //* scanline must padded to this multiple */
  end;

  //- -CC- Really not certain that I got this part right! - It seems to work.
  ResourceAllocFunc = function ( _display: PXDisplay ): XID; cdecl;
          _XPrivate = function (): XPointer; cdecl;
         _Private15 = function ( _display: PXDisplay ): int32; cdecl;
  _XrmHashBucketRec = function: pointer; cdecl;
 p_XrmHashBucketRec = ^_XrmHashBucketRec;
   _XDisplay = record
             ext_data: P_XExtData;        //* hook for extension to hang data */
             private1: _XPrivate;
                   fd: int32;             //* Network socket. */
             private2: int32;
  proto_major_version: int32;             //* major version of server's X protocol */
  proto_minor_version: int32;             //* minor version of servers X protocol */\
               vendor: pchar;             //* vendor of the server hardware */
             private3: XPointer;
             private4: XPointer;
             private5: XPointer;
             private6: XPointer;
       resource_alloc: ResourceAllocFunc; //* allocator function */
           byte_order: int32;             //* screen byte order, LSBFirst, MSBFirst */
          bitmap_unit: int32;             //* padding and data requirements */
           bitmap_pad: int32;             //* padding requirements on bitmaps */
     bitmap_bit_order: int32;             //* LeastSignificant or MostSignificant */
             nformats: int32;             //* number of pixmap formats in list */
        pixmap_format: ^ScreenFormat;     //* pixmap format list */
             private8: int32;
              release: int32;             //* release of the server */
             private9: _XPrivate;
            private10: _XPrivate;
                 qlen: int32;             //* Length of input event queue */
    last_request_read: ulong;            //* seq number of last event read */
              request: ulong;            //* sequence number of last request. */
            private11: XPointer;
            private12: XPointer;
            private13: XPointer;
            private14: XPointer;
     max_request_size: uint32;            //* maximum number 32 bit words in request*/
                   db: _XrmHashBucketRec;
            private15: _Private15;
         display_name: pchar;             //* "host:display" string used on this connect*/
       default_screen: int32;             //* default screen for operations */
             nscreens: int32;             //* number of screens on this server*/
              screens: ^Screen;           //* pointer to list of screens */
        motion_buffer: ulong;            //* size of motion buffer */
            private16: ulong;
          min_keycode: int32;             //* minimum defined keycode */
          max_keycode: int32;             //* maximum defined keycode */
            private17: XPointer;
            private18: XPointer;
            private19: int32;
            xdefaults: XPointer;          //* contents of defaults from server */
     end;
     Display = ^_XDisplay;

  PXSetWindowAttributes = ^XSetWindowAttributes;
  XSetWindowAttributes = record
        background_pixmap: Pixmap;	 //* background or None or ParentRelative */
         background_pixel: ulong;	 //* background pixel */
            border_pixmap: Pixmap;	 //* border of the window */
             border_pixel: ulong;	 //* border pixel value */
              bit_gravity: int32;		 //* one of bit gravity values */
              win_gravity: int32;		 //* one of the window gravity values */
            backing_store: int32;		 //* NotUseful, WhenMapped, Always */
           backing_planes: ulong;   //* planes to be preseved if possible */
            backing_pixel: ulong;   //* value to use in restoring planes */
               save_under: XBool;		 //* should bits under be saved? (popups) */
               event_mask: long;		 //* set of events that should be saved */
    do_not_propagate_mask: long;	   //* set of events that should not propagate */
        override_redirect: XBool;	   //* boolean value for override-redirect */
                _colormap: Colormap; //* color map to be associated with window -CC- Renamed '_colormap' because 'colormap' matches data-type in case-insensitive pascal.
                  _cursor: Cursor;	 //* cursor to be displayed (or None) -CC- Renamed '_cursor' because 'cursor' matches data-type in case-insensitive pascal.
  end;

  XWindowAttributes = record
    //* location of window */
                      x: int32;
                      y: int32;
    //* width and height of window */
                   width: int32;
                  height: int32;
            border_width: int32;	   //* border width of window */
                   depth: int32;     //* depth of window */
                 _visual: ^Visual;   //* the associated visual structure -CC- Rename '_visual' because 'visual' matches data-type in case-insensitive pascal.
                    root: Window;    //* root of screen containing window */
                 c_class: int32;		 //* C++ InputOutput, InputOnly -CC- Took C++ conditional branch because A) Object pascal & B) 'class' is a reserved word.
             bit_gravity: int32;		 //* one of bit gravity values */
             win_gravity: int32;		 //* one of the window gravity values */
           backing_store: int32;     //* NotUseful, WhenMapped, Always */
          backing_planes: ulong;     //* planes to be preserved if possible */
           backing_pixel: ulong;     //* value to be used when restoring planes */
              save_under: XBool;		 //* boolean, should bits under be saved? */
               _colormap: Colormap;	 //* color map to be associated with window -CC- Renamed '_colormap' because 'colormap' matches data-type in case-insensitive pascal
            map_installed: XBool;		 //* boolean, is color map currently installed*/
                map_state: int32;		 //* IsUnmapped, IsUnviewable, IsViewable */
          all_event_masks: long;	   //* set of events all people have interest in*/
          your_event_mask: long;	   //* my event mask */
    do_not_propagate_mask: long;     //* set of events that should not propagate */
        override_redirect: XBool;    //* boolean value for override-redirect */
                  _screen: ^Screen;  //* back pointer to correct screen -CC- Renamed '_screen' because 'screen' matches data-type in case-insensitive pascal
  end;

  pXHostAddress = ^XHostAddress;
  XHostAddress = record
    family: int32;   //* for example FamilyInternet */
    length: int32;   //* length of address, in bytes */
    addres: pointer; //* pointer to where to find the bytes */
  end;

  XServerInterpretedAddress = record
    typelength: int32;            //* length of type string, in bytes */
   valuelength: int32;            //* length of value string, in bytes */
         _type: pchar;            //* pointer to where to find the type string -CC- Renamed '_type' as 'type' is existing pascal reserved word.
         value: pchar;            //* pointer to where to find the address */
  end;

  PXImage = ^_XImage;
  funcs = record
     create_image: function (
                                    _display: PXDisplay; //* display */
                                     var _visual: Visual; //* visual */,
                                      _depth: uint32; //* depth */,
                                     _format: int32; //* format */
                                     _offset: int32; //* offset */
                                        data: pointer; 	//* data */
                                       width: uint32;  //* width */
                                      height: uint32; //* height */,
                                  bitmap_pad: int32; //* bitmap_pad */
                              bytes_per_line: int32 //* bytes_per_line */
                            ): PXImage; cdecl;
    destroy_image: function ( image: PXImage ): int32; cdecl;
        get_pixel: function ( image: PXImage; x: int32; y: int32): ulong; cdecl;
        put_pixel: function ( image: PXImage; x: int32; y: int32; rgb: ulong): int32; cdecl;
        sub_image: function ( image: PXImage; x: int32; y: int32; w: uint32; h: uint32): PXImage; cdecl;
        add_pixel: function ( image: PXImage; rgb: ulong): int32; cdecl;
  end;

  _XImage = record
    //* size of image */
                width: int32;
               height: int32;
              xoffset: int32;   //* number of pixels offset in X direction */
               format: int32;   //* XYBitmap, XYPixmap, ZPixmap */
                 data: pointer; //* pointer to image data */
           byte_order: int32;   //* data byte order, LSBFirst, MSBFirst */
          bitmap_unit: int32;   //* quant. of scanline 8, 16, 32 */
     bitmap_bit_order: int32;   //* LSBFirst, MSBFirst */
           bitmap_pad: int32;   //* 8, 16, 32 either XY or ZPixmap */
                depth: int32;   //* depth of image */
       bytes_per_line: int32;   //* accelarator to next line */
       bits_per_pixel: int32;   //* bits per pixel (ZPixmap) */
             red_mask: ulong;   //* bits in z arrangment */
           green_mask: ulong;
            blue_mask: ulong;
               obdata: XPointer; //* hook for the object routines to hang on */
                    f: funcs;    //- --CC-- bunch of callbacks for modifying image data - see 'funcs'
  end;
  XImage = _XImage;

  pXWindowChanges = ^XWindowChanges;
  XWindowChanges = record
               x: int32;
               y: int32;
           width: int32;
          height: int32;
    border_width: int32;
         sibling: Window;
      stack_mode: int32;
  end;

  pXColor = ^XColor;
  XColor = record
    pixel: ulong;
    red: uint16;
    green: uint16;
    blue: uint16;
    flags: uint8;  //* do_red, do_green, do_blue */
    pad: uint8;
  end;

  pXSegment = ^XSegment;
  XSegment = record
    x1: int16;
    y1: int16;
    x2: int16;
    y2: int16;
  end;

  pXPoint = ^XPoint;
  XPoint = record
    x: int16;
    y: int16;
  end;

  pXRectangle = ^XRectangle;
  XRectangle = record
         x: int16;
         y: int16;
     width: uint16;
    height: uint16;
  end;

  pXArc = ^XArc;
  XArc = record
         x: int16;
         y: int16;
     width: uint16;
    height: uint16;
    angle1: int16;
    angle2: int16;
  end;

  XKeyboardControl = record
     key_click_percent: int32;
          bell_percent: int32;
            bell_pitch: int32;
         bell_duration: int32;
                   led: int32;
              led_mode: int32;
                   key: int32;
      auto_repeat_mode: int32;   //* On, Off, Default */
  end;

  XKeyboardState = record
      key_click_percent: int32;
           bell_percent: int32;
             bell_pitch: uint32;
          bell_duration: uint32;
               led_mask: ulong;
     global_auto_repeat: int32;
           auto_repeats: array[0..31] of uint8;
  end;

  XTimeCoord = record
    _time: Time;   // -CC- Renamed '_time' as 'time' conflicts with data-type in case-insensitive pascal.
        x: int16;
        y: int16;
  end;

  XModifierKeymap = record
    max_keypermod: int32;  //* The server's max # of keys per modifier */
 	  modifiermap: ^KeyCode; //* An 8 by max_keypermod array of modifiers */
  end;

  pXKeyEvent = ^XKeyEvent;
  XKeyEvent = record
          _type: int32;    //* of event -CC- Renamed '_type' because 'type' is pascal reserved word.
         serial: ulong;	 //* # of last request processed by server */
     send_event: XBool;	   //* true if this came from a SendEvent request */
       _display: Display; //* Display the event was read from */ -CC- Renamed '_display' as it matches data-type 'Display' in case-insensitive pascal.
        _window: Window;   //* "event" window it is reported relative to -CC- Renamed '_window' as it matches data-type 'Window' in case-insensitive pascal.
           root: Window;   //* root window that the event occurred on */
      subwindow: Window;	 //* child window */
          _time: Time;     //* milliseconds */ -CC- Renamed '_time' as it matches data-type 'Time' in case-insensitive pascal.
     //* pointer x, y coordinates in event window */
              x: int32;
              y: int32;
     //* coordinates relative to root */
         x_root: int32;
         y_root: int32;
          state: uint32;	 //* key or button mask */
        keycode: uint32;	 //* detail */
    same_screen: XBool;	   //* same screen flag */
  end;
  XKeyPressedEvent = XKeyEvent;
  XKeyReleasedEvent = XKeyEvent;

  XButtonEvent = record
          _type: int32;    //* of event -CC- Renamed '_type' because 'type' is pascal reserved word.
         serial: ulong;	 //* # of last request processed by server */
     send_event: XBool;	   //* true if this came from a SendEvent request */
       _display: Display; //* Display the event was read from */ -CC- Renamed '_display' as it matches data-type 'Display' in case-insensitive pascal.
        _window: Window;   //* "event" window it is reported relative to -CC- Renamed '_window' as it matches data-type 'Window' in case-insensitive pascal.
           root: Window;   //* root window that the event occurred on */
      subwindow: Window;	 //* child window */
          _time: Time;     //* milliseconds */ -CC- Renamed '_time' as it matches data-type 'Time' in case-insensitive pascal.
     //* pointer x, y coordinates in event window */
              x: int32;
              y: int32;
     //* coordinates relative to root */
         x_root: int32;
         y_root: int32;
          state: uint32;	 //* key or button mask */
         button: uint32;	 //* detail */
    same_screen: XBool;    //* same screen flag */
  end;
XButtonPressedEvent = XButtonEvent;
XButtonReleasedEvent = XButtonEvent;

  XMotionEvent = record
          _type: int32;    //* of event -CC- Renamed '_type' because 'type' is pascal reserved word.
         serial: ulong;	 //* # of last request processed by server */
     send_event: XBool;	   //* true if this came from a SendEvent request */
       _display: Display; //* Display the event was read from */ -CC- Renamed '_display' as it matches data-type 'Display' in case-insensitive pascal.
        _window: Window;   //* "event" window it is reported relative to -CC- Renamed '_window' as it matches data-type 'Window' in case-insensitive pascal.
           root: Window;   //* root window that the event occurred on */
      subwindow: Window;	 //* child window */
          _time: Time;     //* milliseconds */ -CC- Renamed '_time' as it matches data-type 'Time' in case-insensitive pascal.
     //* pointer x, y coordinates in event window */
              x: int32;
              y: int32;
     //* coordinates relative to root */
         x_root: int32;
         y_root: int32;
          state: uint32;	 //* key or button mask */
        is_hint: uint8;    //* detail */
    same_screen: XBool;	   //* same screen flag */
  end;
  XPointerMovedEvent = XMotionEvent;

  XCrossingEvent = record
          _type: int32;
         serial: ulong;
     send_event: XBool;
       _display: Display;
        _window: Window;
           root: Window;
      subwindow: Window;
          _time: Time;
              x: int32;
              y: int32;
         x_root: int32;
         y_root: int32;
           mode: int32;
         detail: int32;
    same_screen: XBool;
          focus: XBool;
          state: uint32;
  end;
  XEnterWindowEvent = XCrossingEvent;
  XLeaveWindowEvent = XCrossingEvent;

  XFocusChangeEvent = record
           _type: int32;
         serial: ulong;
     send_event: XBool;
       _display: Display;
        _window: Window;
           mode: int32;
         detail: int32;
  end;

  XFocusInEvent = XFocusChangeEvent;
  XFocusOutEvent = XFocusChangeEvent;

  XKeymapEvent = record
          _type: int32;
         serial: ulong;
     send_event: XBool;
       _display: Display;
        _window: Window;
     key_vector: array[0..31] of uint8;
  end;

  XExposeEvent = record
          _type: int32;
         serial: ulong;
     send_event: XBool;
       _display: Display;
        _window: Window;
             x: int32;
             y: int32;
         width: int32;
        height: int32;
         count: int32;
  end;

  XGraphicsExposeEvent = record
          _type: int32;
         serial: ulong;
     send_event: XBool;
       _display: Display;
      _drawable: Drawable; // -CC- renamed to '_drawable' to avoid conflict with data-type in case-insensitive pascal
              x: int32;
              y: int32;
          width: int32;
         height: int32;
          count: int32;
     major_code: int32;
     minor_code: int32;
  end;

  XNoExposeEvent = record
          _type: int32;
         serial: ulong;
     send_event: XBool;
       _display: Display;
      _drawable: Drawable; // -CC- renamed to '_drawable' to avoid conflict with data-type in case-insensitive pascal
     major_code: int32;
     minor_code: int32;
  end;

  XVisibilityEvent = record
          _type: int32;
         serial: ulong;
     send_event: XBool;
       _display: Display;
        _window: Window;
          state: int32;
  end;

  XCreateWindowEvent = record
                _type: int32;
               serial: ulong;
           send_event: XBool;
             _display: Display;
               parent: Window;
              _window: Window;
                    x: int32;
                    y: int32;
                width: int32;
               height: int32;
         border_width: int32;
    override_redirect: XBool;
  end;

  XDestroyWindowEvent = record
          _type: int32;
         serial: ulong;
     send_event: XBool;
       _display: Display;
          event: Window;
        _window: Window;
  end;

  XUnmapEvent = record
             _type: int32;
            serial: ulong;
        send_event: XBool;
          _display: Display;
             event: Window;
           _window: Window;
    from_configure: XBool;
  end;

  XMapEvent = record
                _type: int32;
               serial: ulong;
           send_event: XBool;
             _display: Display;
                event: Window;
              _window: Window;
    override_redirect: XBool;
  end;

  XMapRequestEvent = record
        _type: int32;
       serial: ulong;
   send_event: XBool;
     _display: Display;
        event: Window;
      _window: Window;
  end;

  XReparentEvent = record
                _type: int32;
               serial: ulong;
           send_event: XBool;
             _display: Display;
                event: Window;
              _window: Window;
               parent: Window;
                    x: int32;
                    y: int32;
    override_redirect: XBool;
  end;

  XConfigureEvent = record
                _type: int32;
               serial: ulong;
           send_event: XBool;
             _display: Display;
                event: Window;
              _window: Window;
                    x: int32;
                    y: int32;
                width: int32;
               height: int32;
         border_width: int32;
                above: Window;
    override_redirect: XBool;
  end;

  XGravityEvent = record
        _type: int32;
       serial: ulong;
   send_event: XBool;
     _display: Display;
        event: Window;
      _window: Window;
            x: int32;
            y: int32;
  end;

  XResizeRequestEvent = record
        _type: int32;
       serial: ulong;
   send_event: XBool;
     _display: Display;
      _window: Window;
        width: int32;
       height: int32;
  end;

  XConfigureRequestEvent = record
            _type: int32;
           serial: ulong;
       send_event: XBool;
         _display: Display;
           parent: Window;
          _window: Window;
                x: int32;
                y:  int32;
            width: int32;
           height: int32;
     border_width: int32;
            above: Window;
           detail: int32;
       value_mask: ulong;
  end;

  XCirculateEvent = record
        _type: int32;
       serial: ulong;
   send_event: XBool;
     _display: Display;
        event: Window;
      _window: Window;
        place: int32;
  end;

  XCirculateRequestEvent = record
        _type: int32;
       serial: ulong;
   send_event: XBool;
     _display: Display;
       parent: Window;
      _window: Window;
        place: int32;
  end;

  XPropertyEvent = record
        _type: int32;
       serial: ulong;
   send_event: XBool;
     _display: Display;
      _window: Window;
        _atom: Atom;
        _time: Time;
        state: int32;
  end;

  XSelectionClearEvent = record
          _type: int32;
         serial: ulong;
     send_event: XBool;
       _display: Display;
        _window: Window;
      selection: Atom;
          _time: Time;
  end;

  XSelectionRequestEvent = record
          _type: int32;
         serial: ulong;
     send_event: XBool;
       _display: Display;
          owner: Window;
      requestor: Window;
      selection: Atom;
         target: atom;
      _property: atom;
          _time: Time;
  end;

  XSelectionEvent = record
          _type: int32;
         serial: ulong;
     send_event: XBool;
       _display: Display;
      requestor: Window;
      selection: Atom;
         target: Atom;
      _property: Atom;
          _time: Time;
  end;

  XColormapEvent = record
          _type: int32;
         serial: ulong;
     send_event: XBool;
       _display: Display;
        _window: Window;
      _colormap: Colormap;
          c_new: XBool;
          state: int32;
  end;

  XClientMessageEvent = record
           _type: int32;
          serial: ulong;
      send_event: XBool;
        _display: Display;
         _window: Window;
    message_type: Atom;
          format: int32;
          data: record
            case int8 of
              0: (b: array[0..19] of uint8);
              1: (s: array[0..9] of int16);
              2: (l: array[0..4] of long);
          end;
  end;

  pXMappingEvent = ^XMappingEvent;
  XMappingEvent = record
            _type: int32;
           serial: ulong;
       send_event: XBool;
         _display: Display;
          _window: Window;
          request: int32;
    first_keycode: int32;
            count: int32;
  end;

  XErrorEvent = record
           _type: int32;
        _display: Display;
      resourceid: XID;
          serial: ulong;
      error_code: int8;
    request_code: int8;
      minor_code: int8;
  end;

  XAnyEvent = record
         _type: int32;
        serial: ulong;
    send_event: XBool;
      _display: Display;
       _window: Window;
  end;

  XGenericEvent = record
        _type: int32;
        serial: ulong;
    send_event: XBool;
      _display: Display;
     extension: int32;
        evtype: int32;
  end;

  XGenericEventCookie = record
         _type: int32;
        serial: ulong;
    send_event: XBool;
      _display: Display;
     extension: int32;
        evtype: int32;
       cookkie: uint32;
          data: XPointer;
  end;

   pXEvent = ^ XEvent;
   XEvent = record
       case int32 of
           0: (              _type: int32                   );
           1: (               xany: XAnyEvent               );
           2: (               xkey: XKeyEvent               );
           3: (            xbutton: XButtonEvent            );
           4: (            xmotion: XMotionEvent            );
           5: (          xcrossing: XCrossingEvent          );
           6: (             xfocus: XFocusChangeEvent       );
           7: (            xexpose: XExposeEvent            );
           8: (    xgraphicsexpose: XGraphicsExposeEvent    );
           9: (          xnoexpose: XNoExposeEvent          );
          10: (        xvisibility: XVisibilityEvent        );
          11: (      xcreatewindow: XCreateWindowEvent      );
          12: (     xdestroywindow: XDestroyWindowEvent     );
          13: (             xunmap: XUnmapEvent             );
          14: (               xmap: XMapEvent               );
          15: (        xmaprequest: XMapRequestEvent        );
          16: (          xreparent: XReparentEvent          );
          17: (         xconfigure: XConfigureEvent         );
          18: (           xgravity: XGravityEvent           );
          19: (     xresizerequest: XResizeRequestEvent     );
          20: (  xconfigurerequest: XConfigureRequestEvent  );
          21: (         xcirculate: XCirculateEvent         );
          22: (  xcirculaterequest: XCirculateRequestEvent  );
          23: (          xproperty: XPropertyEvent          );
          24: (    xselectionclear: XSelectionClearEvent    );
          25: (  xselectionrequest: XSelectionRequestEvent  );
          26: (         xselection: XSelectionEvent         );
          27: (          xcolormap: XColormapEvent          );
          28: (            xclient: XClientMessageEvent     );
          29: (           xmapping: XMappingEvent           );
          30: (             xerror: XErrorEvent             );
          31: (            xkeymap: XKeymapEvent            );
          32: (           xgeneric: XGenericEvent           );
          33: (            xcookie: XGenericEventCookie     );
          34: (                pad: array[0..23] of long    );
       end;

  XCharStruct = record
      lbearing: int16;
      rbearing: int16;
         width: int16;
        ascent: int16;
       descent: int16;
    attributes: uint16;
  end;

  XFontProp = record
      name: Atom;
    card32: ulong;
  end;


  pppXFontStruct = ^ppXFontStruct;
  ppXFontStruct = ^pXFontStruct;
  pXFontStruct = ^XFontStruct;
  XFontStruct = record
               ext_data: ^XExtData;
                    fid: Font;
              direction: uint32;
      min_char_or_byte2: uint32;
      max_char_or_byte2: uint32;
              min_byte1: uint32;
              max_byte1: uint32;
        all_chars_exist: xBool;
           default_char: uint32;
           n_properties: int32;
            properties: ^XFontProp;
            min_bounds: XCharStruct;
            max_bounds: XCharStruct;
              per_char: ^XCharStruct;
               ascent: int32;
              descent: int32;
  end;

  pXTextItem = ^XTextItem;
  XTextItem = record
     chars: pchar;
    nchars: int32;
     delta: int32;
     _font: Font;
  end;

  pXChar2b = ^ XChar2b;
  XChar2b = record
    byte1: uint8;
    byte2: uint8;
  end;

  pXTextItem16 = ^XTextItem16;
  XTextItem16 = record
     chars: XChar2b;
    nchars: int32;
     delta: int32;
     _font: Font;
  end;

  XEDataObject = record
    case int8 of
      0: (      _display: Display       );
      1: (           _gc: GC             );
      2: (       _visual: ^Visual        );
      3: (       _screen: ^Screen        );
      4: ( pixmap_format: ^ScreenFormat  );
      5: (         _font: ^XFontStruct   );
  end;

  XFontSetExtents = record
        max_ink_extent: XRectangle;
    max_logical_extent: XRectangle;
  end;

       XOM = ^_XOM;
      _XOM = record end;
       XOC = ^_XOC;
  XFontSet = ^XOC;
      _XOC = record end;


  PXmbTextItem = ^XmbTextItem;
  XmbTextItem = record
        chars: pchar;
       nchars: int32;
        delta: int32;
     font_set: XFontSet;
  end;

  pXwcTextItem = ^XwcTextItem;
  XwcTextItem = record
        chars: pwidechar;
       nchars: int32;
        delta: int32;
     font_set: XFontSet;
  end;

  XOMCharSetList = record
    charset_count: int32;
     charset_list: ^pchar;
  end;

  XOrientation = (
    XOMOrientation_LTR_TTB,
    XOMOrientation_RTL_TTB,
    XOMOrientation_TTB_LTR,
    XOMOrientation_TTB_RTL,
    XOMOrientation_Context
  );

  XOMOrientation = record
    num_orientation: int32;
        orientation: ^XOrientation;
  end;

  XOMFontInfo = record
            num_font: int32;
    font_struct_list: ^pXFontStruct;
      font_name_list: ^pchar;
  end;

   XIM = ^_XIM;
  _XIM = record end;
   XIC = ^_XIC;
  _XIC = record end;

  XIMProc = procedure( a: XIM; b: XPointer; c: XPointer ); cdecl;

  XICProc = function( a: XIC; b: XPointer; c: XPointer ): XBool; cdecl;

  XIDProc = procedure( var _display: Display; a: XPointer; b: XPointer ); cdecl;

  XIMStyle = ulong;

  XIMStyles = record
        count_styles: uint16;
    supported_styles: ^XIMStyle;
  end;

  XVaNestedList = pointer;

  XIMCallback = record
    client_data: XPointer;
       callback: XIMProc;
  end;

  XICCallback = record
    client_data: XPointer;
       callback: XICProc;
  end;

  XIMFeedback = ulong;

  _XIMText = record
               length: uint16;
             feedback: ^XIMFeedback;
    encoding_is_wchar: XBool;
              _string: record
                case int8 of
                  0: (  multi_byte: pchar      );
                  1: (   wide_char: pwidechar  );
              end;
  end;
  XIMText = _XIMText;

  XIMPreeditState = ulong;

  _XIMPreeditStateNotifyCallbackStruct = record
    state: XIMPreeditState;
  end;
  XIMPreeditStateNotifyCallbackStruct = _XIMPreeditStateNotifyCallbackStruct;

  XIMResetState = ulong;

  XIMStringConversionFeedback = ulong;

  _XIMStringConversionText = record
        length: uint16;
        feedback: ^XIMStringConversionFeedback;
        encoding_is_wchar: XBool;
        _string: record
            case longint of
               0: ( mbs: pchar     );
               1: ( wcs: pwidechar );
        end;
  end;
  XIMStringConversionText = _XIMStringConversionText;

  XIMStringConversionPosition = uint16;

  XIMStringConversionType = uint16;

  XIMStringConversionOperation = uint16;

  XIMCaretDirection = (
    XIMForwardChar,
    XIMBackwardChar,
    XIMForwardWord,
    XIMBackwardWord,
    XIMCaretUp,
    XIMCaretDown,
    XIMNextLine,
    XIMPreviousLine,
    XIMLineStart,
    XIMLineEnd,
    XIMAbsolutePosition,
    XIMDontChange
  );

  _XIMStringConversionCallbackStruct = record
     position: XIMStringConversionPosition;
    direction: XIMCaretDirection;
    operation: XIMStringConversionOperation;
       factor: uint16;
         text: ^XIMStringConversionText;
  end;
  XIMStringConversionCallbackStruct = _XIMStringConversionCallbackStruct;

  _XIMPreeditDrawCallbackStruct = record
         caret: int32;
     chg_first: int32;
    chg_length: int32;
          text: ^XIMText;
  end;
  XIMPreeditDrawCallbackStruct = _XIMPreeditDrawCallbackStruct;

  XIMCaretStyle = (
    XIMIsInvisible,
    XIMIsPrimary,
    XIMIsSecondary
  );

  _XIMPreeditCaretCallbackStruct = record
      position: int32;
     direction: XIMCaretDirection;
         style: XIMCaretStyle;
  end;
  XIMPreeditCaretCallbackStruct = _XIMPreeditCaretCallbackStruct;

  XIMStatusDataType = (
    XIMTextType,
    XIMBitmapType
  );

  _XIMStatusDrawCallbackStruct = record
    _type: XIMStatusDataType;
     data: record
             case int8 of
               0:(    text: ^XIMText  );
               1:(  bitmap: Pixmap    );
     end;
  end;
  XIMStatusDrawCallbackStruct = _XIMStatusDrawCallbackStruct;

  _XIMHotKeyTrigger = record
         _keysym: KeySym;
         modifier: int32;
    modifier_mask: int32;
  end;
  XIMHotKeyTrigger = _XIMHotKeyTrigger;

  _XIMHotKeyTriggers = record
    num_hot_key: int32;
            key: ^XIMHotKeyTrigger;
  end;
  XIMHotKeyTriggers = _XIMHotKeyTriggers;

  XIMHotKeyState = ulong;

  XIMValuesList = record
        count_values: uint16;
    supported_values: ^pchar;
  end;

  XErrorHandler = function( var _display: Display; var event: XErrorEvent): int32; cdecl;
  XIOErrorHandler = function ( var _display: Display ): int32; cdecl;



{------------------------------------------------------------------------------}
{ The types below are not defined in the XLib header, however, Delphi does not
  permit functions to return pointers using the syntax "function(): ^TDataType;"
  Instead we require a "type pDataType = ^DataType;" and then the function
  is adjusted to read "function(): pDataType;"
{------------------------------------------------------------------------------}
type
  pchar = pointer;
  ppchar = ^pchar;
  pppchar = ^ppchar;
  pXTimeCoord = ^XTimeCoord;
  pXModifierKeymap = XModifierKeymap;
  pDisplay = ^Display;
  pColormap = ^Colormap;
  pAtom = ^Atom;
  pKeySym = ^KeySym;
  pXExtCodes = ^XExtCodes;
  pXExtData = ^XExtData;
  pVisual = ^Visual;
  pScreen = ^Screen;
  pXPixmapFormatValues = ^XPixmapFormatValues;
  pint32 = ^int32;
  pXFontSetExtents = ^XFontSetExtents;

  chararray32 = array[0..31] of uint8;
  pchararray32 = ^chararray32;

{------------------------------------------------------------------------------}
{ Callbacks }
{------------------------------------------------------------------------------}
  TDisplayFunction = function( _display: Display ): int32; cdecl;
  TEventFunction = function(_display: Display; event: pXEvent; p: XPointer ): XBool; cdecl;

{------------------------------------------------------------------------------}
{------------------------------------------------------------------------------}

  T_Xmblen = function( str: pchar; len: int32 ): int32; cdecl;
  TXLoadQueryFont = function( _display: Display; _Xconst: pchar ): pXFontStruct; cdecl;
  TXQueryFont = function( _display: Display; font_ID: XID ): pXFontStruct; cdecl;
  TXGetMotionEvents = function( _display: Display; w: Window; start: Time; stop: Time; var nevents_return: int32 ): pXTimeCoord; cdecl;
  TXDeleteModifiermapEntry = function( var modmap: XModifierKeymap; keycode_entry: uint32; modifier: int32 ): pXModifierKeymap; cdecl;
  TXGetModifierMapping = function( _display: Display ): pXModifierKeymap; cdecl;
  TXInsertModifiermapEntry = function( var modmap: XModifierKeymap; keycode_entry: uint32; modifier: int32 ): pXModifierKeymap; cdecl;
  TXNewModifiermap = function ( max_keys_per_mod: int32 ): pXModifierKeymap; cdecl;
  TXCreateImage = function( _display: Display; var _visual: Visual; depth: int32; format: int32; offset: int32; data: pointer; width: int32; height: int32; bitmap_pad: int32; bytes_per_line: int32 ): pXImage; cdecl;
  TXInitImage = function( var image: XImage ) : Status; cdecl;
  TXGetImage = function( _display: Display; d: Drawable; x: int32; y: int32; width: uint32; height: uint32; plane_mask: ulong; format: int32 ): pXImage; cdecl;
  TXGetSubImage = function( _display: Display; d: Drawable; x: int32; y: int32; width: uint32; height: uint32; format: int32; var dest_image: XImage; dest_x: int32; dest_y: int32 ): pXImage; cdecl;
  TXOpenDisplay = function( display_name: pchar ): Display; cdecl;
  TXrmInitialize = procedure; cdecl;
  TXFetchBytes = function( _display: Display; var nbytes_return: int32 ): pchar; cdecl;
  TXFetchBuffer = function( _display: Display; var nbytes_return: int32; buffer: int32 ): pchar; cdecl;
  TXGetAtomName = function ( _display: Display; _atom: Atom ): pchar; cdecl;
  TXGetAtomNames = function( _display: Display; atoms: pAtom; count: int32; var names_return: pchar ): Status; cdecl;
  TXGetDefault = function ( _display: Display; const _program: pchar; const option: pchar ): pchar; cdecl;
  TXDisplayName = function ( const _string: pchar ): pchar; cdecl;
  TXKeysymToString = function ( _keysym: KeySym ): pchar; cdecl;
  TXSynchronize = function( _display: Display; onoff: boolean ): TDisplayFunction; cdecl;
  TXSetAfterFunction = function ( _display: Display; _procedure: TDisplayFunction ): TDisplayFunction; cdecl;
  TXInternAtom = function( _display: Display; atom_name: pchar; only_if_exists: XBool ): Atom; cdecl;
  TXInternAtoms = function ( _dpy: Display; names: ppchar; count: int32; onlyIfExists: XBool; atoms_return: pAtom ): Status; cdecl;
  TXCopyColormapAndFree = function ( _display: Display; _colormap: Colormap ): Colormap; cdecl;
  TXCreateColormap = function ( _display: Display; _window: Window; _visual: Visual; alloc: int32 ): Colormap; cdecl;
  TXCreatePixmapCursor = function ( _display: Display; source_: Pixmap; mask: Pixmap; foreground_color: pXColor; backgroundColor: XColor; x: uint32; y: uint32 ): Cursor; cdecl;
  TXCreateGlyphCursor = function ( _display: Display; source_font: Font; mask_font: Font; source_char: uint32; mask_char: uint32; const foreground_color: XColor; const background_color: XColor ): Cursor; cdecl;
  TXCreateFontCursor = function ( _display: Display; shape: uint32 ): Cursor; cdecl;
  TXLoadFont = function ( _display: Display; const name: pchar ): Font; cdecl;
  TXCreateGC = function ( display: Display; d: Drawable; valuemask: ulong; values: pXGCValues ): GC; cdecl;
  TXGContextFromGC = function ( _gc: GC ): GContext; cdecl;
  TXFlushGC = procedure ( _display: Display; _gc: GC ) cdecl;
  TXCreatePixmap = function ( _display: Display; d: Drawable; width: uint32; height: uint32; depth: uint32 ): Pixmap; cdecl;
  TXCreateBitmapFromData = function ( _display: Display; d: Drawable; const data: pchar; width: uint32; height: uint32 ): Pixmap; cdecl;
  TXCreatePixmapFromBitmapData = function ( _display: Display; d: Drawable; data: pchar; width: uint32; height: uint32; fg: ulong; bg: ulong; depth: uint32 ): Pixmap; cdecl;
  TXCreateSimpleWindow = function ( _display: Display; parent: Window; x: int32; y: int32; width: uint32; height: uint32; border_width: uint32; border: ulong; background: ulong ): Window; cdecl;
  TXGetSelectionOwner = function ( _display: Display; selection: Atom ): Window; cdecl;
  TXCreateWindow = function( _display: Display; parent: Window; x: int32; y: int32; width: uint32; height: uint32; border_width: uint32; depth: uint32; _class: uint32; var _visual: Visual; valuemask: long; attributes: pXSetWindowAttributes ): Window; cdecl;
  TXListInstalledColormaps = function ( _display: Display; w: Window; var num_return: int32 ): pColormap; cdecl;
  TXListProperties = function ( _display: Display; w: Window; var num_prop_return: int32 ): pAtom; cdecl;
  TXListHosts = function ( _display: Display; var nhosts_return: int32; var state_return: XBool ): pXHostAddress; cdecl;
  TXKeycodeToKeysym = function  ( _display: Display; _keycode: uint32; index: int32 ): KeySym; cdecl;
  TXLookupKeysym = function ( key_event: pXKeyEvent; index: uint32 ): KeySym; cdecl;
  TXGetKeyboardMapping = function ( _display: Display; first_keycode: uint32; keycode_count: int32; var keysyms_per_keycode_return: int32 ): pKeySym; cdecl;
  TXStringToKeysym = function ( const _string: pchar ): KeySym; cdecl;
  TXMaxRequestSize = function ( _display: Display ): int32; cdecl;
  TXExtendedMaxRequestSize = function( _display: Display ): int32; cdecl;
  TXResourceManagerString = function ( _display: Display ): pchar; cdecl;
  TXScreenResourceString = function ( _display: Display ): pchar; cdecl;
  TXDisplayMotionBufferSize = function ( _display: Display ): uint32; cdecl;
  TXVisualIDFromVisual = function ( _Visual: pVisual ): VisualID; cdecl;
  TXInitThreads = function: Status; cdecl;
  TXLockDisplay = procedure ( _display: Display ); cdecl;
  TXUnlockDisplay = procedure ( _display: Display ); cdecl;
  TXInitExtension = function ( _display: Display; name: pchar ): pXExtCodes; cdecl;
  TXAddExtension = function ( _display: Display ): pXExtCodes; cdecl;
  TXFindOnExtensionList = function ( var structure: pXExtData; number: int32 ): pXExtData; cdecl;
  TXRootWindow = function( _display: Display; screen_number: int32 ): Window; cdecl;
  TXDefaultRootWindow = function ( _display: Display ): Window; cdecl;
  TXRootWindowOfScreen = function ( _screen: pScreen ): Window; cdecl;
  TXDefaultVisual = function ( _display: Display;  screen_number: int32 ): pVisual; cdecl;
  TXDefaultVisualOfScreen = function ( _screen: pScreen ): pVisual; cdecl;
  TXDefaultGC = function ( _display: Display; screen_number: int32 ): GC; cdecl;
  TXDefaultGCOfScreen = function (_screen: pScreen): GC; cdecl;
  TXBlackPixel = function( _display: Display; screen_number: int32 ): uint32; cdecl;
  TXWhitePixel = function( _display: Display; screen_number: int32 ): uint32; cdecl;
  TXAllPlanes = function: uint32; cdecl;
  TXBlackPixelOfScreen = function ( _screen: pScreen ): uint32; cdecl;
  TXWhitePixelOfScreen = function ( _screen: pScreen ): uint32; cdecl;
  TXNextRequest = function ( _display: Display ): uint32; cdecl;
  TXLastKnownRequestProcessed = function ( _display: Display ): uint32; cdecl;
  TXServerVendor = function( _display: Display ): pchar; cdecl;
  TXDisplayString = function ( _display: Display ): pchar; cdecl;
  TXDefaultColormap = function ( _display: Display; screen_number: int32 ): Colormap; cdecl;
  TXDefaultColormapOfScreen = function ( _screen: pScreen ): Colormap; cdecl;
  TXDisplayOfScreen = function ( _screen: pScreen ): pDisplay; cdecl;
  TXScreenOfDisplay = function ( _display: Display; screen_number: int32 ): pScreen; cdecl;
  TXDefaultScreenOfDisplay = function ( _display: Display ): pScreen; cdecl;
  TXEventMaskOfScreen = function ( _screen: pScreen ): int32; cdecl;
  TXScreenNumberOfScreen = function ( _screen: pScreen ): int32; cdecl;
  TXSetErrorHandler = function ( handler: XErrorHandler ): XErrorHandler; cdecl;
  TXSetIOErrorHandler = function ( handler: XIOErrorHandler	): XIOErrorHandler; cdecl;
  TXListPixmapFormats = function ( _display: Display; var count_return: int32 ): pXPixmapFormatValues; cdecl;
  TXListDepths = function ( _display: Display; screen_number: int32; var count_return: int32 ): pint32; cdecl;
  TXReconfigureWMWindow = function ( _display: Display; w: Window; screen_number: int32; mask: uint32; changes: pXWindowChanges ): Status; cdecl;
  TXGetWMProtocols = function ( _display: Display; w: Window; var protocols_return: pAtom; var count_return: int32 ): Status; cdecl;
  TXSetWMProtocols = function ( _display: Display; _window: Window; protocols: pAtom; count: int32 ): Status; cdecl;
  TXIconifyWindow = function ( _display: Display; w: Window; screen_number: int32 ): Status; cdecl;
  TXWithdrawWindow = function ( _display: Display; w: Window; screen_number: int32 ): Status; cdecl;
  TXGetCommand = function ( _display: Display; w: Window; var argv_return: ppChar; var argc_return: int32 ): Status; cdecl;
  TXGetWMColormapWindows = function ( _display: Display; w: Window; var windows_return: pwindow; varcount_return: int32 ): Status; cdecl;
  TXSetWMColormapWindows = function ( _display: Display; w: Window; colormap_windows: pwindow; count: int32 ): Status; cdecl;
  TXFreeStringList = procedure ( var list: pchar ); cdecl;
  TXSetTransientForHint = function ( _display: Display; w: Window; prop_window: Window ): int32; cdecl;
  TXActivateScreenSaver = function( _display: Display ): int32; cdecl;
  TXAddHost = function ( _display: Display; host: pXHostAddress ): int32; cdecl;
  TXAddHosts = function ( _display: Display; hosts: pXHostAddress; num_hosts: int32 ): int32; cdecl;
  TXAddToExtensionList = function ( var structure: p_XExtData; ext_data: pXExtData ): int32; cdecl;
  TXAddToSaveSet = function ( _display: Display; w: Window ): int32; cdecl;
  TXAllocColor = function ( _display: Display; colormap: Colormap; var screen_in_out: XColor ): Status; cdecl;
  TXAllocColorCells = function ( _display: Display; colormap: Colormap; config: XBool; var plane_masks_return: ulong; nplanes: ulong; var pixels_return: ulong; npixels: int32 ): Status; cdecl;
  TXAllocColorPlanes = function ( _display: Display; _colormap: Colormap; config: XBool; var pixels_return: ulong; ncolors, nreds, ngreens, nblues: int32; var rmask_return: ulong; var gmask_return: ulong; var bmask_return: ulong ): Status; cdecl;
  TXAllocNamedColor = function ( _display: Display; _colormap: Colormap; const color_name: pchar;  var screen_def_return: XColor;  var exact_def_return: XColor ): Status; cdecl;
  TXAllowEvents = function ( _display: Display; event_mode: int32; _time: Time ): int32; cdecl;
  TXAutoRepeatOff = function ( _display: Display ): int32; cdecl;
  TXAutoRepeatOn = function ( _display: Display ): int32; cdecl;
  TXBell = function ( _display: Display; percent: int32 ): int32; cdecl;
  TXBitmapBitOrder = function ( _display: Display ): int32; cdecl;
  TXBitmapPad = function ( _display: Display ): int32; cdecl;
  TXBitmapUnit = function ( _display: Display ): int32; cdecl;
  TXCellsOfScreen = function ( _display: Display; screen: pScreen ): int32; cdecl;
  TXChangeActivePointerGrab = function ( _display: Display; event_mask: uint32; _cursor: Cursor; _time: Time ): int32; cdecl;
  TXChangeGC = function ( _display: Display; gc: GC; valuemask: ulong; var values: XGCValues ): int32; cdecl;
  TXChangeKeyboardControl = function ( _display: Display; value_mask: ulong; var values: XKeyboardControl ): int32; cdecl;
  TXChangeKeyboardMapping = function ( _display: Display; first_keycode: int32; keysyms_per_keycode: int32; _keysyms: pKeySym; num_codes: int32 ): int32; cdecl;
  TXChangePointerControl = function ( _display: Display; do_accel: XBool; do_threashold: XBool; accel_numerator: int32; accel_denominator: int32; threshold: int32 ): int32; cdecl;
  TXChangeProperty = function ( _display: Display; w: Window; _property: Atom; _type: Atom; format: int32; mode: int32; const data: pchar; nelements: int32 ): int32; cdecl;
  TXChangeSaveSet = function ( _display: Display; w: Window; change_mode: int32 ): int32; cdecl;
  TXChangeWindowAttributes = function ( _display: Display; _window: Window; valuemask: ulong; attributes: pXSetWindowAttributes ): int32; cdecl;
  TXCheckIfEvent = function ( _display: Display; var event_return: XEvent; arg: TEventFunction ): XBool; cdecl;
  TXCheckMaskEvent = function ( _display: Display; evenmt_mask: long; var event_return: XEvent ): XBool; cdecl;
  TXCheckTypedEvent = function ( _display: Display; event_type: int32; var event_return: XEvent ): XBool; cdecl;
  TXCheckTypedWindowEvent = function ( _display: Display; w: Window; event_type: int32; var event_return: XEvent ): XBool; cdecl;
  TXCheckWindowEvent = function ( _display: Display; w: Window; event_mask: long; var event_return: XEvent ): XBool; cdecl;
  TXCirculateSubwindows = function ( _display: Display; w: Window; direction: int32 ): int32; cdecl;
  TXCirculateSubwindowsDown = function ( _display: Display; w: Window ): int32; cdecl;
  TXCirculateSubwindowsUp = function ( _display: Display; w: Window ): int32; cdecl;
  TXClearArea = function ( _display: Display; w: Window; x: int32; y: int32; width: uint32; height: uint32; exposures: XBool ): int32; cdecl;
  TXClearWindow = function ( _display: Display; w: Window ): int32; cdecl;
  TXCloseDisplay = function (_display: Display): int32; cdecl;
  TXConfigureWindow = function ( _display: Display; w: Window; value_mask: uint32; var values: XWindowChanges ): int32; cdecl;
  TXConnectionNumber = function ( _display: Display ): int32; cdecl;
  TXConvertSelection = function ( _display: Display; selection: Atom; target: Atom; _property: Atom; requestor: Window; _time: Time ): int32; cdecl;
  TXCopyArea = function ( _display: Display; src: Drawable; dest: Drawable; _gc: GC; src_x: int32; src_y: int32; width: uint32; height: uint32; dest_x: int32; dest_y: int32 ): int32; cdecl;
  TXCopyGC = function ( _display: Display; src: GC; valuemask: ulong; dest: GC ): int32; cdecl;
  TXCopyPlane = function ( _display: Display; src: Drawable; dest: Drawable; _gc: GC; src_x: int32; src_y: int32; width: uint32; height: uint32; dest_x: int32; dest_y: int32; plane: ulong ): int32; cdecl;
  TXDefaultDepth = function ( _display: Display; screen_number: int32 ): int32; cdecl;
  TXDefaultDepthOfScreen = function ( _screen: pScreen ): int32; cdecl;
  TXDefaultScreen = function ( _display: Display ): int32; cdecl;
  TXDefineCursor = function ( _display: Display; w: Window; _ursor: Cursor ): int32; cdecl;
  TXDeleteProperty = function ( _display: Display; w: Window; _property: Atom ): int32; cdecl;
  TXDestroyWindow = function ( _display: Display; _window: Window ): int32; cdecl;
  TXDestroySubwindows = function ( _display: Display; w: Window ): int32; cdecl;
  TXDoesBackingStore = function ( _screen: pScreen ): int32; cdecl;
  TXDoesSaveUnders = function ( _screen: pScreen ): XBool; cdecl;
  TXDisableAccessControl = function ( _display: Display ): int32; cdecl;
  TXDisplayCells = function ( _display: Display; screen_number: int32 ): int32; cdecl;
  TXDisplayHeight = function ( _display: Display; screen_number: int32 ): int32; cdecl;
  TXDisplayHeightMM = function ( _display: Display; screen_number: int32 ): int32; cdecl;
  TXDisplayKeycodes = function ( _display: Display; var min_keycodes_return: int32; var max_keycodes_return: int32 ): int32; cdecl;
  TXDisplayPlanes = function ( _display: Display; screen_number: int32 ): int32; cdecl;
  TXDisplayWidth = function ( _display: Display; screen_number: int32 ): int32; cdecl;
  TXDisplayWidthMM = function ( _display: Display; screen_number: int32 ): int32; cdecl;
  TXDrawArc = function ( _display: Display; d: Drawable; _gc: GC; x: int32; y: int32; width: uint32; height: uint32; angle1: uint32; angle2: uint32 ): int32; cdecl;
  TXDrawArcs = function ( _display: Display; d: Drawable; _gc: GC; arcs: pXArc; narcs: int32 ): int32; cdecl;
  TXDrawImageString = function ( _display: Display; d: Drawable; _gc: GC; x: int32; y: int32; const _string: pchar; length: int32 ): int32; cdecl;
  TXDrawImageString16 = function ( _display: Display; d: Drawable; _gc: GC; x: int32; y: int32; const _string: pXChar2b; length: int32 ): int32; cdecl;
  TXDrawLine = function ( _display: Display; d: Drawable; _gc: GC; x1, y1, x2, y2: int32 ): int32; cdecl;
  TXDrawLines = function ( _display: Display; d: Drawable; _gc: GC; points: pXPoint; npoints: int32; mode: int32 ): int32; cdecl;
  TXDrawPoint = function ( _display: Display; d: Drawable; _gc: GC; x: int32; y: int32 ): int32; cdecl;
  TXDrawPoints = function ( _display: Display; d: Drawable; _gc: GC; points: pXPoint; npoints: int32; mode: int32 ): int32; cdecl;
  TXDrawRectangle = function ( _display: Display; d: Drawable; _gc: GC; x: int32; y: int32; width: uint32; height: uint32 ): int32; cdecl;
  TXDrawRectangles = function ( _display: Display; d: Drawable; _gc: GC; rectangles: pXRectangle; nrectangles: int32 ): int32; cdecl;
  TXDrawSegments = function ( _display: Display; d: Drawable; _gc: GC; segments: pXSegment; nsegments: int32 ): int32; cdecl;
  TXDrawString = function ( _display: Display; d: Drawable; _gc: GC; x: int32; y: int32; const _string: pchar; length: int32 ): int32; cdecl;
  TXDrawString16 = function ( _display: Display; d: Drawable; _gc: GC; x: int32; y: int32; const _string: pXChar2b; length: int32 ): int32; cdecl;
  TXDrawText = function ( _display: Display; d: Drawable; _gc: GC; x: int32; y: int32; items: pXTextItem; nitems: int32 ): int32; cdecl;
  TXDrawText16 = function ( _display: Display; d: Drawable; _gc: GC; x: int32; y: int32; items: pXTextItem16; nitems: int32 ): int32; cdecl;
  TXEnableAccessControl = function ( _display: Display ): int32; cdecl;
  TXEventsQueued = function ( _display: Display; mode: int32 ): int32; cdecl;
  TXFetchName = function ( _display: Display; w: Window; var window_name_return: pchar ): Status; cdecl;
  TXFillArc = function ( _display: Display; d: Drawable; _gc: GC; x: int32; y: int32; width: uint32; height: uint32; angle1: int32; angle2: int32 ): int32; cdecl;
  TXFillArcs = function ( _display: Display; d: Drawable; _gc: GC; arcs: pXArc; narcs: int32 ): int32; cdecl;
  TXFillPolygon = function ( _display: Display; d: Drawable; _gc: GC; points: pXPoint; npoints: int32; shape: int32; mode: int32 ): int32; cdecl;
  TXFillRectangle = function ( _display: Display; d: Drawable; _gc: GC; x: int32; y: int32; width: uint32; height: uint32 ): int32; cdecl;
  TXFillRectangles = function ( _display: Display; d: Drawable; _gc: GC; rectangles: pXRectangle; nrectangles: int32 ): int32; cdecl;
  TXFlush = function ( _display: Display ): int32; cdecl;
  TXForceScreenSaver = function ( _display: Display; mode: int32 ): int32; cdecl;
  TXFree = function ( data: pointer ): int32; cdecl;
  TXFreeColormap = function ( _display: Display; _colormap: Colormap ): int32; cdecl;
  TXFreeColors = function ( _display: Display; _colormap: Colormap; pixels: pulong; npixels: int32; planes: ulong ): int32; cdecl;
  TXFreeCursor = function ( _display: Display; _cursor: Cursor ): int32; cdecl;
  TXFreeExtensionList = function ( list: ppchar ): int32; cdecl;
  TXFreeFont = function ( _display: Display; font_struct: pXFontStruct ): int32; cdecl;
  TXFreeFontInfo = function ( names: ppchar; free_info: pXFontStruct; actual_count: int32 ): int32; cdecl;
  TXFreeFontNames = function ( list: ppchar ): int32; cdecl;
  TXFreeFontPath = function ( list: ppchar ): int32; cdecl;
  TXFreeGC = function ( _display: Display; _gc: GC ): int32; cdecl;
  TXFreeModifiermap = function ( modmap: pXModifierKeymap ): int32; cdecl;
  TXFreePixmap = function ( _display: Display; _pixmap: Pixmap ): int32; cdecl;
  TXGeometry = function ( _display: Display; _screen: int32; const position: pchar; const default_posisiont: pchar; bwidth: uint32; fwidth: uint32; fheight: uint32; xadder: int32; yadder: int32; var x_return: int32; var y_return: int32; var width_return: int32; var height_return: int32 ): int32; cdecl;
  TXGetErrorDatabaseText = function ( _display: Display; const name: pchar; const _message: pchar; const default_string: pchar; buffer_return: pchar; length: int32 ): int32; cdecl;
  TXGetErrorText = function ( _display: Display; code: int32; buffer_return: pchar; length: int32 ): int32; cdecl;
  TXGetFontProperty = function ( font_struct: pXFontStruct; atom: Atom; var value_return: long ): XBool; cdecl;
  TXGetGCValues = function ( _display: Display; _gc: GC; valuemask: ulong; values_return: pXGCValues ): Status; cdecl;
  TXGetGeometry = function ( _display: Display; d: Drawable; var root_return: Window; var x_return: int32; var y_return: int32; var width_return: uint32; var height_return: uint32; var border_width_return: uint32; var depth_return: uint32 ): Status; cdecl;
  TXGetIconName = function ( _display: Display; w: Window; var icon_name_return: pchar ): Status; cdecl;
  TXGetInputFocus = function ( _display: Display; var focus_return: Window; var revert_to_Return: int32 ): int32; cdecl;
  TXGetKeyboardControl = function ( _display: Display; var values_return: XKeyboardState ): int32; cdecl;
  TXGetPointerControl = function ( _display: Display; var accel_numerator_return: int32; var accel_denominator_return: int32; var threashold_return: int32 ) : int32; cdecl;
  TXGetPointerMapping = function ( _display: Display; var map_return: char; nmap: int32 ): int32; cdecl;
  TXGetScreenSaver = function ( _display: Display; var timeout_return: int32; var interval_return: int32; var prefer_blanking_return: int32; var allow_exposures_return: int32 ): int32; cdecl;
  TXGetTransientForHint = function ( _display: Display; w: Window; var prop_window_return: Window ): Status; cdecl;
  TXGetWindowProperty = function ( _display: Display; w: Window; _property: Atom; long_offset: long; long_length: long; delete: XBool; req_type: Atom; var actual_type_return: Atom; var actual_format_return: int32; var nitems_return: ulong; var bytes_after_return: ulong; var prop_return: pchar ): int32; cdecl;
  TXGetWindowAttributes = function ( _display: Display; w: Window; var window_Attributes_return: XWindowAttributes ): Status; cdecl;
  TXGrabButton = function ( _display: Display; button: uint32; modifiers: uint32; grab_window: Window; owner_events: XBool; event_mask: uint32; pointer_mode: int32; keyboard_mode: int32; contine_to: Window; _cursor: Cursor ): int32; cdecl;
  TXGrabKey = function ( _display: Display; keycode: int32; modifiers: int32; grab_window: Window; owner_events: XBool; pointer_mode: int32; keyboard_mode: int32 ): int32; cdecl;
  TXGrabKeyboard = function ( _display: Display; grab_window: Window; owner_events: XBool; pointer_mode: int32; keyboard_mode: int32; _time: Time ): int32; cdecl;
  TXGrabPointer = function ( _display: Display; grab_window: Window; owner_events: XBool; event_mask: uint32; pointer_mode: int32; keyboard_mode: int32; confine_to: Window; _cursor: Cursor; _time: Time ): int32; cdecl;
  TXGrabServer = function ( _display: Display ): int32; cdecl;
  TXHeightMMOfScreen = function ( _screen: pScreen ): int32; cdecl;
  TXHeightOfScreen = function ( _screen: pScreen ): int32; cdecl;
  TXIfEvent = function ( _display: Display; var event_return: XEvent; predicate: TEventFunction; arg: XPointer ): int32; cdecl;
  TXImageByteOrder = function ( _display: Display ): int32; cdecl;
  TXInstallColormap = function ( _display: Display; _colormap: Colormap ): int32; cdecl;
  TXKeysymToKeycode = function ( _display: Display; _keysym: KeySym ): KeyCode; cdecl;
  TXKillClient = function ( _display: Display; resource: XID ): int32; cdecl;
  TXLookupColor = function ( _display: Display; _colormap: Colormap; const color_name: pchar; var exact_def_return: XColor; var screen_def_return: XColor ): Status; cdecl;
  TXLowerWindow = function ( _display: Display; w: Window ): int32; cdecl;
  TXMapRaised = function ( _display: Display; w: Window ): int32; cdecl;
  TXMapSubwindows = function ( _display: Display; w: Window ): int32; cdecl;
  TXMapWindow = function( _display: Display; w: Window ): int32; cdecl;
  TXMaskEvent = function ( _display: Display; event_mask: long; var event_return: XEvent ): int32; cdecl;
  TXMaxCmapsOfScreen = function ( _screen: pScreen ): int32; cdecl;
  TXMinCmapsOfScreen = function ( _screen: pScreen ): int32; cdecl;
  TXMoveResizeWindow = function ( _display: Display; w: Window; x: int32; y: int32; width: uint32; height: uint32 ): int32; cdecl;
  TXMoveWindow = function ( _display: Display; w: Window; x: int32; y: int32 ): int32; cdecl;
  TXNextEvent = function ( _display: Display; var event_return: XEvent ): int32; cdecl;
  TXNoOp = function ( _display: Display ): int32; cdecl;
  TXParseColor = function ( _display: Display; _colormap: Colormap; const spec: pchar; var exact_def_return: XColor ): Status; cdecl;
  TXParseGeometry = function ( const parsestring: pchar; var x_return: int32; var y_return: int32; var width_return: uint32; var height_return: uint32 ): int32; cdecl;
  TXPeekEvent = function ( _display: Display; var event_return: XEvent ): int32; cdecl;
  TXPeekIfEvent = function ( _display: Display; var event_return: XEvent; predicate: TEventFunction; arg: XPointer ): int32; cdecl;
  TXPending = function ( _display: Display ): int32; cdecl;
  TXPlanesOfScreen = function ( _screen: pScreen ): int32; cdecl;
  TXProtocolRevision = function ( _display: Display ): int32; cdecl;
  TXProtocolVersion = function ( _display: Display ): int32; cdecl;
  TXPutBackEvent = function ( _display: Display; event: pXEvent ): int32; cdecl;
  TXPutImage = function ( _display: Display; d: Drawable; _gc: GC; image: pXImage; src_x: int32; src_y: int32; dest_x: int32; dest_y: int32; width: uint32; height: uint32 ): int32; cdecl;
  TXQLength = function ( _display: Display ): int32; cdecl;
  TXQueryBestCursor = function ( _display: Display; d: Drawable; width: uint32; height: uint32; var width_return: uint32; var height_return: uint32 ): Status; cdecl;
  TXQueryBestSize = function ( _display: Display; _class: int32; which_screen: Drawable; width: uint32; height: uint32; var width_return: uint32; var height_return: uint32 ): Status; cdecl;
  TXQueryBestStipple = function ( _display: Display; which_screen: Drawable; width: uint32; height: uint32; var width_return: uint32; var height_return: uint32 ) : Status; cdecl;
  TXQueryBestTile = function ( _display: Display; which_screen: Drawable; width: uint32; height: uint32; var width_return: uint32; var height_return: uint32 ): Status; cdecl;
  TXQueryColor = function ( _display: Display; _colormap: Colormap; def_in_out: pXColor ): int32; cdecl;
  TXQueryColors = function ( _display: Display; _colormap: Colormap; defs_in_out: pXColor; ncolors: int32 ): int32; cdecl;
  TXQueryExtension = function ( _display: Display; const name: pchar; var major_opcode_return: int32; var first_event_return: int32; var first_error_return: int32 ): XBool; cdecl;
  TXQueryKeymap = function ( _display: Display; keys_return: pchararray32 ): int32; cdecl;
  TXQueryPointer = function ( _display: Display; w: Window; var root_return: Window; var child_return: Window; var root_x_return: int32; var root_y_return: int32; var win_x_return: int32; var win_y_return: int32; var mask_return: uint32 ): XBool; cdecl;
  TXQueryTextExtents = function ( _display: Display; font_ID: XID; const _string: pchar; nchars: int32; var direction_return: int32; var font_ascent_return: int32; var font_descent_return: int32; var overall_return: XCharStruct ): int32; cdecl;
  TXQueryTextExtents16 = function ( _display: Display; font_ID: XID; const _string: pXChar2b; nchars: int32; var direction_return: int32; var font_ascent_return: int32; var font_descent_return: int32; var overall_return: XCharStruct ): int32; cdecl;
  TXQueryTree = function( _display: Display; w: Window; var root_return: Window; var parent_return: Window; var children_return: pWindow; var nchildren_return: int32 ): Status; cdecl;
  TXRaiseWindow = function ( _display: Display; w: Window ): int32; cdecl;
  TXReadBitmapFile = function ( _display: Display; d: Drawable; const filename: pchar; var width_return: uint32; var height_return: uint32; var bitmap_return: Pixmap; var x_hot_return: int32; var y_hot_return ): int32; cdecl;
  TXReadBitmapFileData = function ( const filename: pchar; var width_return: uint32; var height_return: uint32; var data_return: pchar; var x_hot_return: int32; var y_hot_return: int32 ): int32; cdecl;
  TXRebindKeysym = function ( _display: Display; _keysym: KeySym; list: pKeySym; mod_count: int32; const _string: pchar; bytes_string: int32 ): int32; cdecl;
  TXRecolorCursor = function ( _display: Display; _cursor: Cursor; var forground_color: XColor; var background_color: XColor ): int32; cdecl;
  TXRefreshKeyboardMapping = function ( event_map: pXMappingEvent ): int32; cdecl;
  TXRemoveFromSaveSet = function ( _display: Display; w: Window ): int32; cdecl;
  TXRemoveHost = function ( _display: Display; host: pXHostAddress ): int32; cdecl;
  TXRemoveHosts = function ( _display: Display; hosts: pXHostAddress; num_hosts: int32 ): int32; cdecl;
  TXReparentWindow = function ( _display: Display; w: Window; parent: Window; x: int32; y: int32 ): int32; cdecl;
  TXResetScreenSaver = function ( _display: Display ): int32; cdecl;
  TXResizeWindow = function ( _display: Display; w: Window; width: uint32; height: uint32 ): int32; cdecl;
  TXRestackWindows = function ( _display: Display; windows: pWindow; nWindows: int32 ): int32; cdecl;
  TXRotateBuffers = function ( _display: Display; rotate: int32 ): int32; cdecl;
  TXRotateWindowProperties = function ( _display: Display; w: Window; properties: pAtom; num_prop: int32; npositions: int32 ): int32; cdecl;
  TXScreenCount = function ( _display: Display ): int32; cdecl;
  TXSelectInput = function ( _display: Display; _window: Window; event_mask: long ): int32; cdecl;
  TXSendEvent = function ( _display: Display; w: Window; propagate: XBool; event_mask: long; event_send: pXEvent ): Status; cdecl;
  TXSetAccessControl = function ( _display: Display; mode: int32 ): int32; cdecl;
  TXSetArcMode = function ( _display: Display; _gc: GC; arc_mode: int32 ): int32; cdecl;
  TXSetBackground = function ( _display: Display; _gc: GC; background: ulong ): int32; cdecl;
  TXSetClipMask = function ( _display: Display; _gc: GC; _pixmap: Pixmap ): int32; cdecl;
  TXSetClipOrigin = function ( _display: Display; _gc: GC; clip_x_origin: int32; clip_y_origin: int32 ): int32; cdecl;
  TXSetClipRectangles = function ( _display: Display; _gc: GC; clip_x_origin: int32; clip_y_origin: int32; rectangles: pXRectangle; n: int32; ordering: int32 ): int32; cdecl;
  TXSetCloseDownMode = function ( _display: Display; close_mode: int32 ): int32; cdecl;
  TXSetCommand = function ( _display: Display; w: Window; argv: ppchar; argc: int32 ): int32; cdecl;
  TXSetDashes = function ( _display: Display; _gc: GC; dash_offset: int32; const dash_list: pchar; n: int32 ): int32; cdecl;
  TXSetFillRule = function ( _display: Display; _gc: GC; fill_rule: int32 ): int32; cdecl;
  TXSetFillStyle = function ( _display: Display; _gc: GC; fill_style: int32 ): int32; cdecl;
  TXSetFont = function ( _display: Display; _gc: GC; _font: Font ): int32; cdecl;
  TXSetFontPath = function ( _display: Display; directories: ppchar; ndirs: int32 ): int32; cdecl;
  TXSetForeground = function ( _display: Display; _gc: GC; foreground: ulong ): int32; cdecl;
  TXSetFunction = function ( _display: Display; _gc: GC; _function: int32 ): int32; cdecl;
  TXSetGraphicsExposures = function ( _display: Display; _gc: GC; graphics_exposures: XBool ): int32; cdecl;
  TXSetIconName = function ( _display: Display; w: Window; const icon_name: pchar ): int32; cdecl;
  TXSetInputFocus = function ( _display: Display; focus: Window; revert_to: int32; _time: Time ): int32; cdecl;
  TXSetLineAttributes = function ( _display: Display; _gc: GC; line_width: uint32; line_Style: int32; cap_style: int32; join_style: int32 ): int32; cdecl;
  TXSetModifierMapping = function ( _display: Display; _modmap: pXModifierKeymap ): int32; cdecl;
  TXSetPlaneMask = function ( _display: Display; _gc: GC; plane_mask: ulong ): int32; cdecl;
  TXSetPointerMapping = function ( _display: Display; const map: pchar; nmap: int32 ): int32; cdecl;
  TXSetScreenSaver = function ( _display: Display; timeout: int32; interval: int32; perfer_blanking: int32; allow_exposures: int32 ): int32; cdecl;
  TXSetSelectionOwner = function ( _display: Display; selection: Atom; owner: Window; _time: Time ): int32; cdecl;
  TXSetState = function ( _display: Display; _gc: GC; foreground: ulong; background: ulong; _function: int32; plane_mask: ulong ): int32; cdecl;
  TXSetStipple = function ( _display: Display; _gc: GC; stipple: Pixmap ): int32; cdecl;
  TXSetSubwindowMode = function ( _display: Display; _gc: GC; subwindow_mode: int32 ): int32; cdecl;
  TXSetTSOrigin = function ( _display: Display; _gc: GC; ts_x_origin: int32; ts_y_origin: int32 ): int32; cdecl;
  TXSetTile = function ( _display: Display; _gc: GC; tile: Pixmap ): int32; cdecl;
  TXSetWindowBackground = function ( _display: Display; w: Window; background_pixel: ulong ): int32; cdecl;
  TXSetWindowBackgroundPixmap = function ( _display: Display; w: Window; background_pixmap: Pixmap ): int32; cdecl;
  TXSetWindowBorder = function ( _display: Display; w: Window; border_pixel: ulong ): int32; cdecl;
  TXSetWindowBorderPixmap = function ( _display: Display; w: Window; border_pixmap: Pixmap ): int32; cdecl;
  TXSetWindowBorderWidth = function ( _display: Display; w: Window; width: uint32 ): int32; cdecl;
  TXSetWindowColormap = function ( _display: Display; w: Window; _colormap: Colormap ): int32; cdecl;
  TXStoreBuffer = function ( _display: Display; const bytes: pchar; nbytes: int32; buffer: int32 ): int32; cdecl;
  TXStoreBytes = function ( _display: Display; const bytes: pchar; nbytes: int32 ): int32; cdecl;
  TXStoreColor = function ( _display: Display; _colormap: Colormap; color: pXColor ): int32; cdecl;
  TXStoreColors = function ( _display: Display; _colormap: Colormap; color: pXColor; ncolors: int32 ): int32; cdecl;
  TXStoreName = function ( _display: Display; w: Window; const window_name: pchar ): int32; cdecl;
  TXStoreNamedColor = function ( _display: Display; _colormap: Colormap; const color: pchar; pixel: ulong; flags: int32 ): int32; cdecl;
  TXSync = function( _display: Display; discard: XBool ): int32; cdecl;
  TXTextExtents = function ( font_struct: pXFontStruct; const _string: pchar; nchars: int32; var direction_return: int32; var font_ascent_return: int32; var font_descent_return: int32; var overall_return: XCharStruct ): int32; cdecl;
  TXTextExtents16 = function ( font_struct: pXFontStruct; const _string: pXChar2b; nchars: int32; var direction_return: int32; var font_ascent_return: int32; var font_descent_return: int32; var overall_return: XCharStruct ): int32; cdecl;
  TXTextWidth = function ( font_struct: pXFontStruct; const _string: pchar; count: int32 ): int32; cdecl;
  TXTextWidth16 = function ( fond_struct: pXFontStruct; _string: pXChar2b; count: int32 ): int32; cdecl;
  TXTranslateCoordinates = function ( _display: Display; src_w: Window; dest_w: Window; src_x: int32; src_y: int32; var dest_x_return: int32; var dest_y_return: int32; var child_return: Window ): XBool; cdecl;
  TXUndefineCursor = function ( _display: Display; w: Window ): int32; cdecl;
  TXUngrabButton = function ( _display: Display; button: uint32; modifiers: uint32; grab_window: Window ): int32; cdecl;
  TXUngrabKey = function ( _display: Display; keycode: int32; modifiers: uint32; grab_window: Window ): int32; cdecl;
  TXUngrabKeyboard = function ( _display: Display; _time: Time ): int32; cdecl;
  TXUngrabPointer = function ( _display: Display; _time: Time ): int32; cdecl;
  TXUngrabServer = function ( _display: Display ): int32; cdecl;
  TXUninstallColormap = function ( _display: Display; _colormap: Colormap ): int32; cdecl;
  TXUnloadFont = function ( _display: Display; _font: Font ): int32; cdecl;
  TXUnmapSubwindows = function ( _display: Display; w: Window ): int32; cdecl;
  TXUnmapWindow = function (_display: Display; _window: Window ): int32; cdecl;
  TXVendorRelease = function ( _display: Display ): int32; cdecl;
  TXWarpPointer = function ( _display: Display; src_w: Window; dest_w: Window; src_x: int32; src_y: int32; src_width: int32; src_height: int32; dest_x: int32; dest_y: int32 ): int32; cdecl;
  TXWidthMMOfScreen = function ( _screen: pScreen ): int32; cdecl;
  TXWidthOfScreen = function ( _screen: pScreen ): int32; cdecl;
  TXWindowEvent = function ( _display: Display; w: Window; event_mask: long; var event_return: XEvent ): int32; cdecl;
  TXWriteBitmapFile = function ( _display: Display; const filename: pchar; bitmap: Pixmap; width: uint32; height: uint32; x_hot: int32; y_hot: int32 ): int32; cdecl;
  TXSupportsLocale = function: XBool; cdecl;
  TXSetLocaleModifiers = function ( const modifier_list: pchar ): pchar; cdecl;
  TXOpenOM = function ( _display: Display; rdb: p_XrmHashBucketRec; const res_name: pchar; const res_class: pchar ): XOM; cdecl;
  TXCloseOM = function ( om: XOM ): Status; cdecl;
  TXDisplayOfOM = function ( om: XOM ): pDisplay; cdecl;
  TXLocaleOfOM = function ( om: XOM ): pchar; cdecl;
  TXDestroyOC = procedure ( oc: XOC ); cdecl;
  TXOMOfOC = function ( oc: XOC ): XOM; cdecl;
  TXCreateFontSet = function ( _display: Display; const base_font_name_list: pchar; missing_charset_list: pppchar; missing_charset_count: pint32; def_string: ppchar ): XFontSet; cdecl;
  TXFreeFontSet = procedure( _display: Display; font_Set: XFontSet ); cdecl;
  TXFontsOfFontSet = function ( font_set: XFontSet; font_struct_list: pppXFontStruct; font_name_list: pppchar ): int32; cdecl;
  TXBaseFontNameListOfFontSet = function ( font_set: XFontSet ): pchar; cdecl;
  TXLocaleOfFontSet = function ( font_Set: XFontSet ): pchar; cdecl;
  TXContextDependentDrawing = function( font_Set: XFontSet ): XBool; cdecl;
  TXDirectionalDependentDrawing = function ( font_Set: XFontSet ): XBool; cdecl;
  TXContextualDrawing = function ( font_Set: XFontSet ): XBool; cdecl;
  TXExtentsOfFontSet = function ( font_Set: XFontSet ): pXFontSetExtents; cdecl;
  TXmbTextEscapement = function ( font_Set: XFontSet; const text: pchar; bytes_text: int32 ): int32; cdecl;
  TXwcTextEscapement = function ( font_Set: XFontSet; const text: pwidechar; num_wchars: int32 ): int32; cdecl;
  TXutf8TextEscapement = function ( font_Set: XFontSet; const text: pchar; bytes_text: int32 ): int32; cdecl;
  TXmbTextExtents = function ( font_Set: XFontSet; const text: pchar; bytes_text: int32; var overall_ink_return: XRectangle; var overall_logical_return: XRectangle ): int32; cdecl;
  TXwcTextExtents = function ( font_Set: XFontSet; const text: pWideChar; numb_wchars: int32; var overall_ink_return: XRectangle; var overall_logical_return: XRectangle ): int32; cdecl;
  TXutf8TextExtents = function ( font_Set: XFontSet; const text: pchar; bytes_text: int32; var overall_ink_return: XRectangle; var overall_logical_return: XRectangle ): int32; cdecl;
  TXmbTextPerCharExtents = function ( font_Set: XFontSet; const text: pchar; bytes_text: int32; ink_extents_buffer: pXRectangle; logical_extents_buffer: pXRectangle; buffer_size: int32; var num_chars: int32; var overall_ink_return: XRectangle; var overall_logical_return: XRectangle ): Status; cdecl;
  TXwcTextPerCharExtents = function ( font_Set: XFontSet; const text: pwidechar; num_wchars: int32; ink_extents_buffer: pXRectangle; logical_extents_buffer: pXRectangle; buffer_size: int32; var num_chars: int32; var overall_ink_return: XRectangle; var overall_logical_return: XRectangle ): Status; cdecl;
  TXutf8TextPerCharExtents = function ( font_Set: XFontSet; const text: pchar; bytes_text: int32; ink_extents_buffer: pXRectangle; logical_extents_buffer: pXRectangle; buffer_size: int32; var num_chars: int32; var overall_ink_return: XRectangle; var overall_logical_return: XRectangle ): Status; cdecl;
  TXmbDrawText = procedure ( _display: Display; d: Drawable; _gc: GC; x: int32; y: int32; text_items: pXmbTextItem; nitems: int32 ); cdecl;
  TXwcDrawText = procedure ( _display: Display; d: Drawable; _gc: GC; x: int32; y: int32; text_items: pXwcTextItem; nitems: int32 ); cdecl;
  TXutf8DrawText = procedure ( _display: Display; d: Drawable; _gc: GC; x: int32; y: int32; text_items: pXmbTextItem; nitems: int32 ); cdecl;
  TXmbDrawString = procedure ( _display: Display; d: Drawable; _gc: GC; x: int32; y: int32; const text: pchar; bytes_text: int32 ); cdecl;
  TXwcDrawString = procedure ( _display: Display; d: Drawable; _gc: GC; x: int32; y: int32; const text: pWideChar; num_wchars: int32 ); cdecl;
  TXutf8DrawString = procedure ( _display: Display; d: Drawable; font_set: XFontSet; gc: GC; x: int32; y: int32; const text: pchar; bytes_text: int32 ); cdecl;
  TXmbDrawImageString = procedure ( _display: Display; d: Drawable; font_set: XFontSet; gc: GC; x: int32; y: int32; const text: pchar; bytes_text: int32 ); cdecl;
  TXwcDrawImageString = procedure ( _display: Display; d: Drawable; font_set: XFontSet; gc: GC; x: int32; y: int32; const text: pWideChar; num_wchars: int32 ); cdecl;
  TXutf8DrawImageString = procedure ( _display: Display; d: Drawable; font_set: XFontSet; gc: GC; x: int32; y: int32; const text: pchar; bytes_text: int32 ); cdecl;
  TXOpenIM = function ( dpy: Display; var rdb: _XrmHashBucketRec; res_name: pchar; res_class: pchar ): XIM; cdecl;
  TXCloseIM = function ( _ic: XIC ): Status; cdecl;
  TXDisplayOfIM = function ( _ic: XIC ): pDisplay; cdecl;
  TXLocaleOfIM = function ( _ic: XIC ): pchar; cdecl;
  TXDestroyIC = procedure ( _ic: XIC ); cdecl;
  TXSetICFocus = procedure ( _ic: XIC ); cdecl;
  TXUnsetICFocus = procedure ( _ic: XIC ); cdecl;
  TXwcResetIC = function ( _ic: XIC ): pWideChar; cdecl;
  TXmbResetIC = function: pchar; cdecl;
  TXutf8ResetIC = function ( _ic: XIC ): pchar; cdecl;

{------------------------------------------------------------------------------
            UnTranslated
-------------------------------------------------------------------------------
extern int _Xdebug;
extern char **XListFonts( Display*		/* display */, _Xconst char*	/* pattern */, int			/* maxnames */, int*		/* actual_count_return */ );
extern char **XListFontsWithInfo(  Display*		/* display */,  _Xconst char*	/* pattern */,  int			/* maxnames */,  int*		/* count_return */,  XFontStruct**	/* info_return */ );
extern char **XGetFontPath( Display*		/* display */, int*		/* npaths_return */ );
extern char **XListExtensions( Display*		/* display */, int*		/* nextensions_return */ );
extern XExtData **XEHeadOfExtensionList( XEDataObject	/* object */ );
extern Display *XDisplayOfOM( XOM			/* om */ );
extern char *XLocaleOfOM( XOM			/* om */ );
extern XOC XCreateOC( XOM			/* om */, ) _X_SENTINEL(0);
extern char *XSetOCValues( XOC			/* oc */, ) _X_SENTINEL(0);
extern char *XGetOCValues( XOC			/* oc */, ) _X_SENTINEL(0);
extern char *XGetIMValues( XIM /* im */, ... ) _X_SENTINEL(0);
extern char *XSetIMValues( XIM /* im */, ... ) _X_SENTINEL(0);
extern XIC XCreateIC( XIM /* im */, ... ) _X_SENTINEL(0);
extern char *XSetICValues( XIC /* ic */, ... ) _X_SENTINEL(0);
extern char *XGetICValues( XIC /* ic */, ... ) _X_SENTINEL(0);
extern XIM XIMOfIC( XIC /* ic */ );
extern Bool XFilterEvent( XEvent*	/* event */, Window	/* window */ );
extern int XmbLookupString( XIC			/* ic */, XKeyPressedEvent*	/* event */, char*		/* buffer_return */, int			/* bytes_buffer */, KeySym*		/* keysym_return */, Status*		/* status_return */ );
extern int XwcLookupString( XIC			/* ic */, XKeyPressedEvent*	/* event */, wchar_t*		/* buffer_return */, int			/* wchars_buffer */, KeySym*		/* keysym_return */, Status*		/* status_return */ );
extern int Xutf8LookupString( XIC			/* ic */, XKeyPressedEvent*	/* event */, char*		/* buffer_return */ int			/* bytes_buffer */, KeySym*		/* keysym_return */, Status*		/* status_return */ );
extern XVaNestedList XVaCreateNestedList( int /*unused*/, ... ) _X_SENTINEL(0);
extern Bool XRegisterIMInstantiateCallback( Display*			/* dpy */, struct _XrmHashBucketRec*	/* rdb */, char*			/* res_name */, char*			/* res_class */, XIDProc			/* callback */, XPointer			/* client_data */);
extern Bool XUnregisterIMInstantiateCallback( Display*			/* dpy */, struct _XrmHashBucketRec*	/* rdb */, char*			/* res_name */, char*			/* res_class */, XIDProc			/* callback */, XPointer			/* client_data */ );
typedef void (*XConnectionWatchProc)( Display*			/* dpy */, XPointer			/* client_data */, int				/* fd */, Bool			/* opening */,	 /* open or close flag */ XPointer*			/* watch_data */ /* open sets, close uses */ );
extern Status XInternalConnectionNumbers( Display*			/* dpy */, int**			/* fd_return */, int*			/* count_return */ );
extern void XProcessInternalConnection( Display*			/* dpy */, int				/* fd */ );
extern Status XAddConnectionWatch( Display*			/* dpy */, XConnectionWatchProc	/* callback */, XPointer			/* client_data */ );
extern void XRemoveConnectionWatch( Display*			/* dpy */, XConnectionWatchProc	/* callback */, XPointer			/* client_data */ );
extern void XSetAuthorization( char *			/* name */, int				/* namelen */, char *			/* data */, int				/* datalen */ );
extern int _Xmbtowc( wchar_t *			/* wstr */, char *			/* str */, int				/* len */ );
extern int _Xwctomb( char *			/* str */, wchar_t			/* wc */ );
extern Bool XGetEventData( Display*			/* dpy */, XGenericEventCookie*	/* cookie*/ );
extern void XFreeEventData( Display*			/* dpy */, XGenericEventCookie*	/* cookie*/ );
-------------------------------------------------------------------------------}

{------------------------------------------------------------------------------}
{       Variables representing entry poitns into X11 lib entry points          }
{------------------------------------------------------------------------------}

var
                        _Xmblen: T_Xmblen = nil;
                 XLoadQueryFont: TXLoadQueryFont = nil;
                     XQueryFont: TXQueryFont = nil;
               XGetMotionEvents: TXGetMotionEvents = nil;
        XDeleteModifiermapEntry: TXDeleteModifiermapEntry = nil;
            XGetModifierMapping: TXGetModifierMapping = nil;
        XInsertModifiermapEntry: TXInsertModifiermapEntry = nil;
                XNewModifiermap: TXNewModifiermap = nil;
                   XCreateImage: TXCreateImage = nil;
                     XInitImage: TXInitImage = nil;
                      XGetImage: TXGetImage = nil;
                   XGetSubImage: TXGetSubImage = nil;
                   XOpenDisplay: TXOpenDisplay = nil;
                  XrmInitialize: TXrmInitialize = nil;
                    XFetchBytes: TXFetchBytes = nil;
                   XFetchBuffer: TXFetchBuffer = nil;
                   XGetAtomName: TXGetAtomName = nil;
                  XGetAtomNames: TXGetAtomNames = nil;
                    XGetDefault: TXGetDefault = nil;
                   XDisplayName: TXDisplayName = nil;
                XKeysymToString: TXKeysymToString = nil;
                   XSynchronize: TXSynchronize = nil;
              XSetAfterFunction: TXSetAfterFunction = nil;
                    XInternAtom: TXInternAtom = nil;
                   XInternAtoms: TXInternAtoms = nil;
           XCopyColormapAndFree: TXCopyColormapAndFree = nil;
                XCreateColormap: TXCreateColormap = nil;
            XCreatePixmapCursor: TXCreatePixmapCursor = nil;
             XCreateGlyphCursor: TXCreateGlyphCursor = nil;
              XCreateFontCursor: TXCreateFontCursor = nil;
                      XLoadFont: TXLoadFont = nil;
                      XCreateGC: TXCreateGC = nil;
                XGContextFromGC: TXGContextFromGC = nil;
                       XFlushGC: TXFlushGC = nil;
                  XCreatePixmap: TXCreatePixmap = nil;
          XCreateBitmapFromData: TXCreateBitmapFromData = nil;
    XCreatePixmapFromBitmapData: TXCreatePixmapFromBitmapData = nil;
            XCreateSimpleWindow: TXCreateSimpleWindow = nil;
             XGetSelectionOwner: TXGetSelectionOwner = nil;
                  XCreateWindow: TXCreateWindow = nil;
        XListInstalledColormaps: TXListInstalledColormaps = nil;
                XListProperties: TXListProperties = nil;
                     XListHosts: TXListHosts = nil;
               XKeycodeToKeysym: TXKeycodeToKeysym = nil;
//                  XLookupKeysym: TXLookupKeysym = nil; //- conflicts with constant of same name?
            XGetKeyboardMapping: TXGetKeyboardMapping = nil;
                XStringToKeysym: TXStringToKeysym = nil;
                XMaxRequestSize: TXMaxRequestSize = nil;
        XExtendedMaxRequestSize: TXExtendedMaxRequestSize = nil;
         XResourceManagerString: TXResourceManagerString = nil;
          XScreenResourceString: TXScreenResourceString = nil;
       XDisplayMotionBufferSize: TXDisplayMotionBufferSize = nil;
            XVisualIDFromVisual: TXVisualIDFromVisual = nil;
                   XInitThreads: TXInitThreads = nil;
                   XLockDisplay: TXLockDisplay = nil;
                 XUnlockDisplay: TXUnlockDisplay = nil;
                 XInitExtension: TXInitExtension = nil;
                  XAddExtension: TXAddExtension = nil;
           XFindOnExtensionList: TXFindOnExtensionList = nil;
                    XRootWindow: TXRootWindow = nil;
             XDefaultRootWindow: TXDefaultRootWindow = nil;
            XRootWindowOfScreen: TXRootWindowOfScreen = nil;
                 XDefaultVisual: TXDefaultVisual = nil;
         XDefaultVisualOfScreen: TXDefaultVisualOfScreen = nil;
                     XDefaultGC: TXDefaultGC = nil;
             XDefaultGCOfScreen: TXDefaultGCOfScreen = nil;
                    XBlackPixel: TXBlackPixel = nil;
                    XWhitePixel: TXWhitePixel = nil;
                     XAllPlanes: TXAllPlanes = nil;
            XBlackPixelOfScreen: TXBlackPixelOfScreen = nil;
            XWhitePixelOfScreen: TXWhitePixelOfScreen = nil;
                   XNextRequest: TXNextRequest = nil;
     XLastKnownRequestProcessed: TXLastKnownRequestProcessed = nil;
                  XServerVendor: TXServerVendor = nil;
                 XDisplayString: TXDisplayString = nil;
               XDefaultColormap: TXDefaultColormap = nil;
       XDefaultColormapOfScreen: TXDefaultColormapOfScreen = nil;
               XDisplayOfScreen: TXDisplayOfScreen = nil;
               XScreenOfDisplay: TXScreenOfDisplay = nil;
        XDefaultScreenOfDisplay: TXDefaultScreenOfDisplay = nil;
             XEventMaskOfScreen: TXEventMaskOfScreen = nil;
          XScreenNumberOfScreen: TXScreenNumberOfScreen = nil;
               XSetErrorHandler: TXSetErrorHandler = nil;
             XSetIOErrorHandler: TXSetIOErrorHandler = nil;
             XListPixmapFormats: TXListPixmapFormats = nil;
                    XListDepths: TXListDepths = nil;
           XReconfigureWMWindow: TXReconfigureWMWindow = nil;
                XGetWMProtocols: TXGetWMProtocols = nil;
                XSetWMProtocols: TXSetWMProtocols = nil;
                 XIconifyWindow: TXIconifyWindow = nil;
                XWithdrawWindow: TXWithdrawWindow = nil;
                    XGetCommand: TXGetCommand = nil;
          XGetWMColormapWindows: TXGetWMColormapWindows = nil;
          XSetWMColormapWindows: TXSetWMColormapWindows = nil;
                XFreeStringList: TXFreeStringList = nil;
           XSetTransientForHint: TXSetTransientForHint = nil;
           XActivateScreenSaver: TXActivateScreenSaver = nil;
                       XAddHost: TXAddHost = nil;
                      XAddHosts: TXAddHosts = nil;
            XAddToExtensionList: TXAddToExtensionList = nil;
                  XAddToSaveSet: TXAddToSaveSet = nil;
                    XAllocColor: TXAllocColor = nil;
               XAllocColorCells: TXAllocColorCells = nil;
              XAllocColorPlanes: TXAllocColorPlanes = nil;
               XAllocNamedColor: TXAllocNamedColor = nil;
                   XAllowEvents: TXAllowEvents = nil;
                 XAutoRepeatOff: TXAutoRepeatOff = nil;
                  XAutoRepeatOn: TXAutoRepeatOn = nil;
                          XBell: TXBell = nil;
                XBitmapBitOrder: TXBitmapBitOrder = nil;
                     XBitmapPad: TXBitmapPad = nil;
                    XBitmapUnit: TXBitmapUnit = nil;
                 XCellsOfScreen: TXCellsOfScreen = nil;
       XChangeActivePointerGrab: TXChangeActivePointerGrab = nil;
                      XChangeGC: TXChangeGC = nil;
         XChangeKeyboardControl: TXChangeKeyboardControl = nil;
         XChangeKeyboardMapping: TXChangeKeyboardMapping = nil;
          XChangePointerControl: TXChangePointerControl = nil;
                XChangeProperty: TXChangeProperty = nil;
                 XChangeSaveSet: TXChangeSaveSet = nil;
        XChangeWindowAttributes: TXChangeWindowAttributes = nil;
                  XCheckIfEvent: TXCheckIfEvent = nil;
                XCheckMaskEvent: TXCheckMaskEvent = nil;
               XCheckTypedEvent: TXCheckTypedEvent = nil;
         XCheckTypedWindowEvent: TXCheckTypedWindowEvent = nil;
              XCheckWindowEvent: TXCheckWindowEvent = nil;
           XCirculateSubwindows: TXCirculateSubwindows = nil;
       XCirculateSubwindowsDown: TXCirculateSubwindowsDown = nil;
         XCirculateSubwindowsUp: TXCirculateSubwindowsUp = nil;
                     XClearArea: TXClearArea = nil;
                   XClearWindow: TXClearWindow = nil;
                  XCloseDisplay: TXCloseDisplay = nil;
               XConfigureWindow: TXConfigureWindow = nil;
              XConnectionNumber: TXConnectionNumber = nil;
              XConvertSelection: TXConvertSelection = nil;
                      XCopyArea: TXCopyArea = nil;
                        XCopyGC: TXCopyGC = nil;
                     XCopyPlane: TXCopyPlane = nil;
                  XDefaultDepth: TXDefaultDepth = nil;
          XDefaultDepthOfScreen: TXDefaultDepthOfScreen = nil;
                 XDefaultScreen: TXDefaultScreen = nil;
                  XDefineCursor: TXDefineCursor = nil;
                XDeleteProperty: TXDeleteProperty = nil;
                 XDestroyWindow: TXDestroyWindow = nil;
             XDestroySubwindows: TXDestroySubwindows = nil;
              XDoesBackingStore: TXDoesBackingStore = nil;
                XDoesSaveUnders: TXDoesSaveUnders = nil;
          XDisableAccessControl: TXDisableAccessControl = nil;
                  XDisplayCells: TXDisplayCells = nil;
                 XDisplayHeight: TXDisplayHeight = nil;
               XDisplayHeightMM: TXDisplayHeightMM = nil;
               XDisplayKeycodes: TXDisplayKeycodes = nil;
                 XDisplayPlanes: TXDisplayPlanes = nil;
                  XDisplayWidth: TXDisplayWidth = nil;
                XDisplayWidthMM: TXDisplayWidthMM = nil;
                       XDrawArc: TXDrawArc = nil;
                      XDrawArcs: TXDrawArcs = nil;
               XDrawImageString: TXDrawImageString = nil;
             XDrawImageString16: TXDrawImageString16 = nil;
                      XDrawLine: TXDrawLine = nil;
                     XDrawLines: TXDrawLines = nil;
                     XDrawPoint: TXDrawPoint = nil;
                    XDrawPoints: TXDrawPoints = nil;
                 XDrawRectangle: TXDrawRectangle = nil;
                XDrawRectangles: TXDrawRectangles = nil;
                  XDrawSegments: TXDrawSegments = nil;
                    XDrawString: TXDrawString = nil;
                  XDrawString16: TXDrawString16 = nil;
                      XDrawText: TXDrawText = nil;
                    XDrawText16: TXDrawText16 = nil;
           XEnableAccessControl: TXEnableAccessControl = nil;
                  XEventsQueued: TXEventsQueued = nil;
                     XFetchName: TXFetchName = nil;
                       XFillArc: TXFillArc = nil;
                      XFillArcs: TXFillArcs = nil;
                   XFillPolygon: TXFillPolygon = nil;
                 XFillRectangle: TXFillRectangle = nil;
                XFillRectangles: TXFillRectangles = nil;
                         XFlush: TXFlush = nil;
              XForceScreenSaver: TXForceScreenSaver = nil;
                          XFree: TXFree = nil;
                  XFreeColormap: TXFreeColormap = nil;
                    XFreeColors: TXFreeColors = nil;
                    XFreeCursor: TXFreeCursor = nil;
             XFreeExtensionList: TXFreeExtensionList = nil;
                      XFreeFont: TXFreeFont = nil;
                  XFreeFontInfo: TXFreeFontInfo = nil;
                 XFreeFontNames: TXFreeFontNames = nil;
                  XFreeFontPath: TXFreeFontPath = nil;
                        XFreeGC: TXFreeGC = nil;
               XFreeModifiermap: TXFreeModifiermap = nil;
                    XFreePixmap: TXFreePixmap = nil;
                      XGeometry: TXGeometry = nil;
          XGetErrorDatabaseText: TXGetErrorDatabaseText = nil;
                  XGetErrorText: TXGetErrorText = nil;
               XGetFontProperty: TXGetFontProperty = nil;
                   XGetGCValues: TXGetGCValues = nil;
                   XGetGeometry: TXGetGeometry = nil;
                   XGetIconName: TXGetIconName = nil;
                 XGetInputFocus: TXGetInputFocus = nil;
            XGetKeyboardControl: TXGetKeyboardControl = nil;
             XGetPointerControl: TXGetPointerControl = nil;
             XGetPointerMapping: TXGetPointerMapping = nil;
                XGetScreenSaver: TXGetScreenSaver = nil;
           XGetTransientForHint: TXGetTransientForHint = nil;
             XGetWindowProperty: TXGetWindowProperty = nil;
           XGetWindowAttributes: TXGetWindowAttributes = nil;
                    XGrabButton: TXGrabButton = nil;
                       XGrabKey: TXGrabKey = nil;
                  XGrabKeyboard: TXGrabKeyboard = nil;
                   XGrabPointer: TXGrabPointer = nil;
                    XGrabServer: TXGrabServer = nil;
              XHeightMMOfScreen: TXHeightMMOfScreen = nil;
                XHeightOfScreen: TXHeightOfScreen = nil;
                       XIfEvent: TXIfEvent = nil;
                XImageByteOrder: TXImageByteOrder = nil;
               XInstallColormap: TXInstallColormap = nil;
               XKeysymToKeycode: TXKeysymToKeycode = nil;
                    XKillClient: TXKillClient = nil;
                   XLookupColor: TXLookupColor = nil;
                   XLowerWindow: TXLowerWindow = nil;
                     XMapRaised: TXMapRaised = nil;
                 XMapSubwindows: TXMapSubwindows = nil;
                     XMapWindow: TXMapWindow = nil;
                     XMaskEvent: TXMaskEvent = nil;
              XMaxCmapsOfScreen: TXMaxCmapsOfScreen = nil;
              XMinCmapsOfScreen: TXMinCmapsOfScreen = nil;
              XMoveResizeWindow: TXMoveResizeWindow = nil;
                    XMoveWindow: TXMoveWindow = nil;
                     XNextEvent: TXNextEvent = nil;
                          XNoOp: TXNoOp = nil;
                    XParseColor: TXParseColor = nil;
                 XParseGeometry: TXParseGeometry = nil;
                     XPeekEvent: TXPeekEvent = nil;
                   XPeekIfEvent: TXPeekIfEvent = nil;
                       XPending: TXPending = nil;
                XPlanesOfScreen: TXPlanesOfScreen = nil;
              XProtocolRevision: TXProtocolRevision = nil;
               XProtocolVersion: TXProtocolVersion = nil;
                  XPutBackEvent: TXPutBackEvent = nil;
                      XPutImage: TXPutImage = nil;
                       XQLength: TXQLength = nil;
               XQueryBestCursor: TXQueryBestCursor = nil;
                 XQueryBestSize: TXQueryBestSize = nil;
              XQueryBestStipple: TXQueryBestStipple = nil;
                 XQueryBestTile: TXQueryBestTile = nil;
                    XQueryColor: TXQueryColor = nil;
                   XQueryColors: TXQueryColors = nil;
                XQueryExtension: TXQueryExtension = nil;
                   XQueryKeymap: TXQueryKeymap = nil;
                  XQueryPointer: TXQueryPointer = nil;
              XQueryTextExtents: TXQueryTextExtents = nil;
            XQueryTextExtents16: TXQueryTextExtents16 = nil;
                     XQueryTree: TXQueryTree = nil;
                   XRaiseWindow: TXRaiseWindow = nil;
                XReadBitmapFile: TXReadBitmapFile = nil;
            XReadBitmapFileData: TXReadBitmapFileData = nil;
                  XRebindKeysym: TXRebindKeysym = nil;
                 XRecolorCursor: TXRecolorCursor = nil;
        XRefreshKeyboardMapping: TXRefreshKeyboardMapping = nil;
             XRemoveFromSaveSet: TXRemoveFromSaveSet = nil;
                    XRemoveHost: TXRemoveHost = nil;
                   XRemoveHosts: TXRemoveHosts = nil;
                XReparentWindow: TXReparentWindow = nil;
              XResetScreenSaver: TXResetScreenSaver = nil;
                  XResizeWindow: TXResizeWindow = nil;
                XRestackWindows: TXRestackWindows = nil;
                 XRotateBuffers: TXRotateBuffers = nil;
        XRotateWindowProperties: TXRotateWindowProperties = nil;
                   XScreenCount: TXScreenCount = nil;
                   XSelectInput: TXSelectInput = nil;
                     XSendEvent: TXSendEvent = nil;
              XSetAccessControl: TXSetAccessControl = nil;
                    XSetArcMode: TXSetArcMode = nil;
                 XSetBackground: TXSetBackground = nil;
                   XSetClipMask: TXSetClipMask = nil;
                 XSetClipOrigin: TXSetClipOrigin = nil;
             XSetClipRectangles: TXSetClipRectangles = nil;
              XSetCloseDownMode: TXSetCloseDownMode = nil;
                    XSetCommand: TXSetCommand = nil;
                     XSetDashes: TXSetDashes = nil;
                   XSetFillRule: TXSetFillRule = nil;
                  XSetFillStyle: TXSetFillStyle = nil;
                       XSetFont: TXSetFont = nil;
                   XSetFontPath: TXSetFontPath = nil;
                 XSetForeground: TXSetForeground = nil;
                   XSetFunction: TXSetFunction = nil;
          XSetGraphicsExposures: TXSetGraphicsExposures = nil;
                   XSetIconName: TXSetIconName = nil;
                 XSetInputFocus: TXSetInputFocus = nil;
             XSetLineAttributes: TXSetLineAttributes = nil;
            XSetModifierMapping: TXSetModifierMapping = nil;
                  XSetPlaneMask: TXSetPlaneMask = nil;
             XSetPointerMapping: TXSetPointerMapping = nil;
                XSetScreenSaver: TXSetScreenSaver = nil;
             XSetSelectionOwner: TXSetSelectionOwner = nil;
                      XSetState: TXSetState = nil;
                    XSetStipple: TXSetStipple = nil;
              XSetSubwindowMode: TXSetSubwindowMode = nil;
                   XSetTSOrigin: TXSetTSOrigin = nil;
                       XSetTile: TXSetTile = nil;
           XSetWindowBackground: TXSetWindowBackground = nil;
     XSetWindowBackgroundPixmap: TXSetWindowBackgroundPixmap = nil;
               XSetWindowBorder: TXSetWindowBorder = nil;
         XSetWindowBorderPixmap: TXSetWindowBorderPixmap = nil;
          XSetWindowBorderWidth: TXSetWindowBorderWidth = nil;
             XSetWindowColormap: TXSetWindowColormap = nil;
                   XStoreBuffer: TXStoreBuffer = nil;
                    XStoreBytes: TXStoreBytes = nil;
                    XStoreColor: TXStoreColor = nil;
                   XStoreColors: TXStoreColors = nil;
                     XStoreName: TXStoreName = nil;
               XStoreNamedColor: TXStoreNamedColor = nil;
                          XSync: TXSync = nil;
                   XTextExtents: TXTextExtents = nil;
                 XTextExtents16: TXTextExtents16 = nil;
                     XTextWidth: TXTextWidth = nil;
                   XTextWidth16: TXTextWidth16 = nil;
          XTranslateCoordinates: TXTranslateCoordinates = nil;
                XUndefineCursor: TXUndefineCursor = nil;
                  XUngrabButton: TXUngrabButton = nil;
                     XUngrabKey: TXUngrabKey = nil;
                XUngrabKeyboard: TXUngrabKeyboard = nil;
                 XUngrabPointer: TXUngrabPointer = nil;
                  XUngrabServer: TXUngrabServer = nil;
             XUninstallColormap: TXUninstallColormap = nil;
                    XUnloadFont: TXUnloadFont = nil;
               XUnmapSubwindows: TXUnmapSubwindows = nil;
                   XUnmapWindow: TXUnmapWindow = nil;
                 XVendorRelease: TXVendorRelease = nil;
                   XWarpPointer: TXWarpPointer = nil;
               XWidthMMOfScreen: TXWidthMMOfScreen = nil;
                 XWidthOfScreen: TXWidthOfScreen = nil;
                   XWindowEvent: TXWindowEvent = nil;
               XWriteBitmapFile: TXWriteBitmapFile = nil;
                XSupportsLocale: TXSupportsLocale = nil;
            XSetLocaleModifiers: TXSetLocaleModifiers = nil;
                        XOpenOM: TXOpenOM = nil;
                       XCloseOM: TXCloseOM = nil;
                   XDisplayOfOM: TXDisplayOfOM = nil;
                    XLocaleOfOM: TXLocaleOfOM = nil;
                     XDestroyOC: TXDestroyOC = nil;
                        XOMOfOC: TXOMOfOC = nil;
                 XCreateFontSet: TXCreateFontSet = nil;
                   XFreeFontSet: TXFreeFontSet = nil;
                XFontsOfFontSet: TXFontsOfFontSet = nil;
     XBaseFontNameListOfFontSet: TXBaseFontNameListOfFontSet = nil;
               XLocaleOfFontSet: TXLocaleOfFontSet = nil;
       XContextDependentDrawing: TXContextDependentDrawing = nil;
   XDirectionalDependentDrawing: TXDirectionalDependentDrawing = nil;
             XContextualDrawing: TXContextualDrawing = nil;
              XExtentsOfFontSet: TXExtentsOfFontSet = nil;
              XmbTextEscapement: TXmbTextEscapement = nil;
              XwcTextEscapement: TXwcTextEscapement = nil;
            Xutf8TextEscapement: TXutf8TextEscapement = nil;
                 XmbTextExtents: TXmbTextExtents = nil;
                 XwcTextExtents: TXwcTextExtents = nil;
               Xutf8TextExtents: TXutf8TextExtents = nil;
          XmbTextPerCharExtents: TXmbTextPerCharExtents = nil;
          XwcTextPerCharExtents: TXwcTextPerCharExtents = nil;
        Xutf8TextPerCharExtents: TXutf8TextPerCharExtents = nil;
                    XmbDrawText: TXmbDrawText = nil;
                    XwcDrawText: TXwcDrawText = nil;
                  Xutf8DrawText: TXutf8DrawText = nil;
                  XmbDrawString: TXmbDrawString = nil;
                  XwcDrawString: TXwcDrawString = nil;
                Xutf8DrawString: TXutf8DrawString = nil;
             XmbDrawImageString: TXmbDrawImageString = nil;
             XwcDrawImageString: TXwcDrawImageString = nil;
           Xutf8DrawImageString: TXutf8DrawImageString = nil;
                        XOpenIM: TXOpenIM = nil;
                       XCloseIM: TXCloseIM = nil;
                   XDisplayOfIM: TXDisplayOfIM = nil;
                    XLocaleOfIM: TXLocaleOfIM = nil;
                     XDestroyIC: TXDestroyIC = nil;
                    XSetICFocus: TXSetICFocus = nil;
                  XUnsetICFocus: TXUnsetICFocus = nil;
                     XwcResetIC: TXwcResetIC = nil;
                     XmbResetIC: TXmbResetIC = nil;
                   Xutf8ResetIC: TXutf8ResetIC = nil;

{------------------------------------------------------------------------------}
{       Variables representing entry poitns into X11 lib entry points          }
{------------------------------------------------------------------------------}

function RootWindow(dpy: Display; scr: int32 ): Window;
function DefaultScreen( dpy: Display ): int32;
function DefaultVisual(dpy: Display; scr: int32): Visual;
function DefaultDepth(dpy : Display; scr : int32) : int32;
function ScreenOfDisplay( dpy: Display; scr: int32): Screen;

// ------- REMAINING MACROS NOT TRANSLATED..

//#define ConnectionNumber(dpy) 	(((_XPrivDisplay)(dpy))->fd)
//#define DefaultRootWindow(dpy) 	(ScreenOfDisplay(dpy,DefaultScreen(dpy))->root)
//#define DefaultGC(dpy, scr) 	(ScreenOfDisplay(dpy,scr)->default_gc)
//#define BlackPixel(dpy, scr) 	(ScreenOfDisplay(dpy,scr)->black_pixel)
//#define WhitePixel(dpy, scr) 	(ScreenOfDisplay(dpy,scr)->white_pixel)
//#define AllPlanes 		((unsigned long)~0L)
//#define QLength(dpy) 		(((_XPrivDisplay)(dpy))->qlen)
//#define DisplayWidth(dpy, scr) 	(ScreenOfDisplay(dpy,scr)->width)
//#define DisplayHeight(dpy, scr) (ScreenOfDisplay(dpy,scr)->height)
//#define DisplayWidthMM(dpy, scr)(ScreenOfDisplay(dpy,scr)->mwidth)
//#define DisplayHeightMM(dpy, scr)(ScreenOfDisplay(dpy,scr)->mheight)
//#define DisplayPlanes(dpy, scr) (ScreenOfDisplay(dpy,scr)->root_depth)
//#define DisplayCells(dpy, scr) 	(DefaultVisual(dpy,scr)->map_entries)
//#define ScreenCount(dpy) 	(((_XPrivDisplay)(dpy))->nscreens)
//#define ServerVendor(dpy) 	(((_XPrivDisplay)(dpy))->vendor)
//#define ProtocolVersion(dpy) 	(((_XPrivDisplay)(dpy))->proto_major_version)
//#define ProtocolRevision(dpy) 	(((_XPrivDisplay)(dpy))->proto_minor_version)
//#define VendorRelease(dpy) 	(((_XPrivDisplay)(dpy))->release)
//#define DisplayString(dpy) 	(((_XPrivDisplay)(dpy))->display_name)
//#define DefaultColormap(dpy, scr)(ScreenOfDisplay(dpy,scr)->cmap)
//#define BitmapUnit(dpy) 	(((_XPrivDisplay)(dpy))->bitmap_unit)
//#define BitmapBitOrder(dpy) 	(((_XPrivDisplay)(dpy))->bitmap_bit_order)
//#define BitmapPad(dpy) 		(((_XPrivDisplay)(dpy))->bitmap_pad)
//#define ImageByteOrder(dpy) 	(((_XPrivDisplay)(dpy))->byte_order)
//#define NextRequest(dpy)	(((_XPrivDisplay)(dpy))->request + 1)
//#define LastKnownRequestProcessed(dpy)	(((_XPrivDisplay)(dpy))->last_request_read)
///* macros for screen oriented applications (toolkit) */
//#define DefaultScreenOfDisplay(dpy) ScreenOfDisplay(dpy,DefaultScreen(dpy))
//#define DisplayOfScreen(s)	((s)->display)
//#define RootWindowOfScreen(s)	((s)->root)
//#define BlackPixelOfScreen(s)	((s)->black_pixel)
//#define WhitePixelOfScreen(s)	((s)->white_pixel)
//#define DefaultColormapOfScreen(s)((s)->cmap)
//#define DefaultDepthOfScreen(s)	((s)->root_depth)
//#define DefaultGCOfScreen(s)	((s)->default_gc)
//#define DefaultVisualOfScreen(s)((s)->root_visual)
//#define WidthOfScreen(s)	((s)->width)
//#define HeightOfScreen(s)	((s)->height)
//#define WidthMMOfScreen(s)	((s)->mwidth)
//#define HeightMMOfScreen(s)	((s)->mheight)
//#define PlanesOfScreen(s)	((s)->root_depth)
//#define CellsOfScreen(s)	(DefaultVisualOfScreen((s))->map_entries)
//#define MinCmapsOfScreen(s)	((s)->min_maps)
//#define MaxCmapsOfScreen(s)	((s)->max_maps)
//#define DoesSaveUnders(s)	((s)->save_unders)
//#define DoesBackingStore(s)	((s)->backing_store)
//#define EventMaskOfScreen(s)	((s)->root_input_mask)
//#define XAllocID(dpy) ((*((_XPrivDisplay)(dpy))->resource_alloc)((dpy)))


implementation
uses
  sysutils,
  dg.dynlib;

{------------------------------------------------------------------------------}
{           Constants and variables used to load the X11 library               }
{------------------------------------------------------------------------------}
const
  cLibName = 'libX11.so.6'; //- using symlink present on most *nix variants.

var
  XLibrary: IDynLib = nil;

{------------------------------------------------------------------------------}
{                        Macro functions implemented                           }
{------------------------------------------------------------------------------}

function RootWindow(dpy: Display; scr: int32 ): Window;
begin
  Result := ScreenOfDisplay(dpy,scr).root;
end;

function DefaultScreen( dpy: Display ): int32;
begin
   Result:=(dpy)^.default_screen;
end;

function ScreenOfDisplay( dpy: Display; scr: int32): Screen;
begin
  Result := Screen(Pointer(NativeUInt( dpy^.screens ) + (scr*Sizeof(pointer)))^);
end;

function DefaultVisual(dpy: Display; scr: int32): Visual;
begin
   Result:=(ScreenOfDisplay(dpy,scr)).root_visual^;
end;

function DefaultDepth(dpy : Display; scr : int32) : int32;
begin
   DefaultDepth:=(ScreenOfDisplay(dpy,scr)).root_depth;
end;

{------------------------------------------------------------------------------}
{                          Load Entry Points                                   }
{------------------------------------------------------------------------------}
function LoadEntryPoints: boolean;
begin
  _Xmblen := XLibrary.GetProcAddress('_Xmblen');
  XLoadQueryFont := XLibrary.GetProcAddress('XLoadQueryFont');
  XQueryFont := XLibrary.GetProcAddress('XQueryFont');
  XGetMotionEvents := XLibrary.GetProcAddress('XGetMotionEvents');
  XDeleteModifiermapEntry := XLibrary.GetProcAddress('XDeleteModifiermapEntry');
  XGetModifierMapping := XLibrary.GetProcAddress('XGetModifierMapping');
  XInsertModifiermapEntry := XLibrary.GetProcAddress('XInsertModifiermapEntry');
  XNewModifiermap := XLibrary.GetProcAddress('XNewModifiermap');
  XCreateImage := XLibrary.GetProcAddress('XCreateImage');
  XInitImage := XLibrary.GetProcAddress('XInitImage');
  XGetImage := XLibrary.GetProcAddress('XGetImage');
  XGetSubImage := XLibrary.GetProcAddress('XGetSubImage');
  XOpenDisplay := XLibrary.GetProcAddress('XOpenDisplay');
  XrmInitialize := XLibrary.GetProcAddress('XrmInitialize');
  XFetchBytes := XLibrary.GetProcAddress('XFetchBytes');
  XFetchBuffer := XLibrary.GetProcAddress('XFetchBuffer');
  XGetAtomName := XLibrary.GetProcAddress('XGetAtomName');
  XGetAtomNames := XLibrary.GetProcAddress('XGetAtomNames');
  XGetDefault := XLibrary.GetProcAddress('XGetDefault');
  XDisplayName := XLibrary.GetProcAddress('XDisplayName');
  XKeysymToString := XLibrary.GetProcAddress('XKeysymToString');
  XSynchronize := XLibrary.GetProcAddress('XSynchronize');
  XSetAfterFunction := XLibrary.GetProcAddress('XSetAfterFunction');
  XInternAtom := XLibrary.GetProcAddress('XInternAtom');
  XInternAtoms := XLibrary.GetProcAddress('XInternAtoms');
  XCopyColormapAndFree := XLibrary.GetProcAddress('XCopyColormapAndFree');
  XCreateColormap := XLibrary.GetProcAddress('XCreateColormap');
  XCreatePixmapCursor := XLibrary.GetProcAddress('XCreatePixmapCursor');
  XCreateGlyphCursor := XLibrary.GetProcAddress('XCreateGlyphCursor');
  XCreateFontCursor := XLibrary.GetProcAddress('XCreateFontCursor');
  XLoadFont := XLibrary.GetProcAddress('XLoadFont');
  XCreateGC := XLibrary.GetProcAddress('XCreateGC');
  XGContextFromGC := XLibrary.GetProcAddress('XGContextFromGC');
  XFlushGC := XLibrary.GetProcAddress('XFlushGC');
  XCreatePixmap := XLibrary.GetProcAddress('XCreatePixmap');
  XCreateBitmapFromData := XLibrary.GetProcAddress('XCreateBitmapFromData');
  XCreatePixmapFromBitmapData := XLibrary.GetProcAddress('XCreatePixmapFromBitmapData');
  XCreateSimpleWindow := XLibrary.GetProcAddress('XCreateSimpleWindow');
  XGetSelectionOwner := XLibrary.GetProcAddress('XGetSelectionOwner');
  XCreateWindow := XLibrary.GetProcAddress('XCreateWindow');
  XListInstalledColormaps := XLibrary.GetProcAddress('XListInstalledColormaps');
  XListProperties := XLibrary.GetProcAddress('XListProperties');
  XListHosts := XLibrary.GetProcAddress('XListHosts');
  XKeycodeToKeysym := XLibrary.GetProcAddress('XKeycodeToKeysym');
//  XLookupKeysym := XLibrary.GetProcAddress(fLibHandle,'XLookupKeysym');
  XGetKeyboardMapping := XLibrary.GetProcAddress('XGetKeyboardMapping');
  XStringToKeysym := XLibrary.GetProcAddress('XStringToKeysym');
  XMaxRequestSize := XLibrary.GetProcAddress('XMaxRequestSize');
  XExtendedMaxRequestSize := XLibrary.GetProcAddress('XExtendedMaxRequestSize');
  XResourceManagerString := XLibrary.GetProcAddress('XResourceManagerString');
  XScreenResourceString := XLibrary.GetProcAddress('XScreenResourceString');
  XDisplayMotionBufferSize := XLibrary.GetProcAddress('XDisplayMotionBufferSize');
  XVisualIDFromVisual := XLibrary.GetProcAddress('XVisualIDFromVisual');
  XInitThreads := XLibrary.GetProcAddress('XInitThreads');
  XLockDisplay := XLibrary.GetProcAddress('XLockDisplay');
  XUnlockDisplay := XLibrary.GetProcAddress('XUnlockDisplay');
  XInitExtension := XLibrary.GetProcAddress('XInitExtension');
  XAddExtension := XLibrary.GetProcAddress('XAddExtension');
  XFindOnExtensionList := XLibrary.GetProcAddress('XFindOnExtensionList');
  XRootWindow := XLibrary.GetProcAddress('XRootWindow');
  XDefaultRootWindow := XLibrary.GetProcAddress('XDefaultRootWindow');
  XRootWindowOfScreen := XLibrary.GetProcAddress('XRootWindowOfScreen');
  XDefaultVisual := XLibrary.GetProcAddress('XDefaultVisual');
  XDefaultVisualOfScreen := XLibrary.GetProcAddress('XDefaultVisualOfScreen');
  XDefaultGC := XLibrary.GetProcAddress('XDefaultGC');
  XDefaultGCOfScreen := XLibrary.GetProcAddress('XDefaultGCOfScreen');
  XBlackPixel := XLibrary.GetProcAddress('XBlackPixel');
  XWhitePixel := XLibrary.GetProcAddress('XWhitePixel');
  XAllPlanes := XLibrary.GetProcAddress('XAllPlanes');
  XBlackPixelOfScreen := XLibrary.GetProcAddress('XBlackPixelOfScreen');
  XWhitePixelOfScreen := XLibrary.GetProcAddress('XWhitePixelOfScreen');
  XNextRequest := XLibrary.GetProcAddress('XNextRequest');
  XLastKnownRequestProcessed := XLibrary.GetProcAddress('XLastKnownRequestProcessed');
  XServerVendor := XLibrary.GetProcAddress('XServerVendor');
  XDisplayString := XLibrary.GetProcAddress('XDisplayString');
  XDefaultColormap := XLibrary.GetProcAddress('XDefaultColormap');
  XDefaultColormapOfScreen := XLibrary.GetProcAddress('XDefaultColormapOfScreen');
  XDisplayOfScreen := XLibrary.GetProcAddress('XDisplayOfScreen');
  XScreenOfDisplay := XLibrary.GetProcAddress('XScreenOfDisplay');
  XDefaultScreenOfDisplay := XLibrary.GetProcAddress('XDefaultScreenOfDisplay');
  XEventMaskOfScreen := XLibrary.GetProcAddress('XEventMaskOfScreen');
  XScreenNumberOfScreen := XLibrary.GetProcAddress('XScreenNumberOfScreen');
  XSetErrorHandler := XLibrary.GetProcAddress('XSetErrorHandler');
  XSetIOErrorHandler := XLibrary.GetProcAddress('XSetIOErrorHandler');
  XListPixmapFormats := XLibrary.GetProcAddress('XListPixmapFormats');
  XListDepths := XLibrary.GetProcAddress('XListDepths');
  XReconfigureWMWindow := XLibrary.GetProcAddress('XReconfigureWMWindow');
  XGetWMProtocols := XLibrary.GetProcAddress('XGetWMProtocols');
  XSetWMProtocols := XLibrary.GetProcAddress('XSetWMProtocols');
  XIconifyWindow := XLibrary.GetProcAddress('XIconifyWindow');
  XWithdrawWindow := XLibrary.GetProcAddress('XWithdrawWindow');
  XGetCommand := XLibrary.GetProcAddress('XGetCommand');
  XGetWMColormapWindows := XLibrary.GetProcAddress('XGetWMColormapWindows');
  XSetWMColormapWindows := XLibrary.GetProcAddress('XSetWMColormapWindows');
  XFreeStringList := XLibrary.GetProcAddress('XFreeStringList');
  XSetTransientForHint := XLibrary.GetProcAddress('XSetTransientForHint');
  XActivateScreenSaver := XLibrary.GetProcAddress('XActivateScreenSaver');
  XAddHost := XLibrary.GetProcAddress('XAddHost');
  XAddHosts := XLibrary.GetProcAddress('XAddHosts');
  XAddToExtensionList := XLibrary.GetProcAddress('XAddToExtensionList');
  XAddToSaveSet := XLibrary.GetProcAddress('XAddToSaveSet');
  XAllocColor := XLibrary.GetProcAddress('XAllocColor');
  XAllocColorCells := XLibrary.GetProcAddress('XAllocColorCells');
  XAllocColorPlanes := XLibrary.GetProcAddress('XAllocColorPlanes');
  XAllocNamedColor := XLibrary.GetProcAddress('XAllocNamedColor');
  XAllowEvents := XLibrary.GetProcAddress('XAllowEvents');
  XAutoRepeatOff := XLibrary.GetProcAddress('XAutoRepeatOff');
  XAutoRepeatOn := XLibrary.GetProcAddress('XAutoRepeatOn');
  XBell := XLibrary.GetProcAddress('XBell');
  XBitmapBitOrder := XLibrary.GetProcAddress('XBitmapBitOrder');
  XBitmapPad := XLibrary.GetProcAddress('XBitmapPad');
  XBitmapUnit := XLibrary.GetProcAddress('XBitmapUnit');
  XCellsOfScreen := XLibrary.GetProcAddress('XCellsOfScreen');
  XChangeActivePointerGrab := XLibrary.GetProcAddress('XChangeActivePointerGrab');
  XChangeGC := XLibrary.GetProcAddress('XChangeGC');
  XChangeKeyboardControl := XLibrary.GetProcAddress('XChangeKeyboardControl');
  XChangeKeyboardMapping := XLibrary.GetProcAddress('XChangeKeyboardMapping');
  XChangePointerControl := XLibrary.GetProcAddress('XChangePointerControl');
  XChangeProperty := XLibrary.GetProcAddress('XChangeProperty');
  XChangeSaveSet := XLibrary.GetProcAddress('XChangeSaveSet');
  XChangeWindowAttributes := XLibrary.GetProcAddress('XChangeWindowAttributes');
  XCheckIfEvent := XLibrary.GetProcAddress('XCheckIfEvent');
  XCheckMaskEvent := XLibrary.GetProcAddress('XCheckMaskEvent');
  XCheckTypedEvent := XLibrary.GetProcAddress('XCheckTypedEvent');
  XCheckTypedWindowEvent := XLibrary.GetProcAddress('XCheckTypedWindowEvent');
  XCheckWindowEvent := XLibrary.GetProcAddress('XCheckWindowEvent');
  XCirculateSubwindows := XLibrary.GetProcAddress('XCirculateSubwindows');
  XCirculateSubwindowsDown := XLibrary.GetProcAddress('XCirculateSubwindowsDown');
  XCirculateSubwindowsUp := XLibrary.GetProcAddress('XCirculateSubwindowsUp');
  XClearArea := XLibrary.GetProcAddress('XClearArea');
  XClearWindow := XLibrary.GetProcAddress('XClearWindow');
  XCloseDisplay := XLibrary.GetProcAddress('XCloseDisplay');
  XConfigureWindow := XLibrary.GetProcAddress('XConfigureWindow');
  XConnectionNumber := XLibrary.GetProcAddress('XConnectionNumber');
  XConvertSelection := XLibrary.GetProcAddress('XConvertSelection');
  XCopyArea := XLibrary.GetProcAddress('XCopyArea');
  XCopyGC := XLibrary.GetProcAddress('XCopyGC');
  XCopyPlane := XLibrary.GetProcAddress('XCopyPlane');
  XDefaultDepth := XLibrary.GetProcAddress('XDefaultDepth');
  XDefaultDepthOfScreen := XLibrary.GetProcAddress('XDefaultDepthOfScreen');
  XDefaultScreen := XLibrary.GetProcAddress('XDefaultScreen');
  XDefineCursor := XLibrary.GetProcAddress('XDefineCursor');
  XDeleteProperty := XLibrary.GetProcAddress('XDeleteProperty');
  XDestroyWindow := XLibrary.GetProcAddress('XDestroyWindow');
  XDestroySubwindows := XLibrary.GetProcAddress('XDestroySubwindows');
  XDoesBackingStore := XLibrary.GetProcAddress('XDoesBackingStore');
  XDoesSaveUnders := XLibrary.GetProcAddress('XDoesSaveUnders');
  XDisableAccessControl := XLibrary.GetProcAddress('XDisableAccessControl');
  XDisplayCells := XLibrary.GetProcAddress('XDisplayCells');
  XDisplayHeight := XLibrary.GetProcAddress('XDisplayHeight');
  XDisplayHeightMM := XLibrary.GetProcAddress('XDisplayHeightMM');
  XDisplayKeycodes := XLibrary.GetProcAddress('XDisplayKeycodes');
  XDisplayPlanes := XLibrary.GetProcAddress('XDisplayPlanes');
  XDisplayWidth := XLibrary.GetProcAddress('XDisplayWidth');
  XDisplayWidthMM := XLibrary.GetProcAddress('XDisplayWidthMM');
  XDrawArc := XLibrary.GetProcAddress('XDrawArc');
  XDrawArcs := XLibrary.GetProcAddress('XDrawArcs');
  XDrawImageString := XLibrary.GetProcAddress('XDrawImageString');
  XDrawImageString16 := XLibrary.GetProcAddress('XDrawImageString16');
  XDrawLine := XLibrary.GetProcAddress('XDrawLine');
  XDrawLines := XLibrary.GetProcAddress('XDrawLines');
  XDrawPoint := XLibrary.GetProcAddress('XDrawPoint');
  XDrawPoints := XLibrary.GetProcAddress('XDrawPoints');
  XDrawRectangle := XLibrary.GetProcAddress('XDrawRectangle');
  XDrawRectangles := XLibrary.GetProcAddress('XDrawRectangles');
  XDrawSegments := XLibrary.GetProcAddress('XDrawSegments');
  XDrawString := XLibrary.GetProcAddress('XDrawString');
  XDrawString16 := XLibrary.GetProcAddress('XDrawString16');
  XDrawText := XLibrary.GetProcAddress('XDrawText');
  XDrawText16 := XLibrary.GetProcAddress('XDrawText16');
  XEnableAccessControl := XLibrary.GetProcAddress('XEnableAccessControl');
  XEventsQueued := XLibrary.GetProcAddress('XEventsQueued');
  XFetchName := XLibrary.GetProcAddress('XFetchName');
  XFillArc := XLibrary.GetProcAddress('XFillArc');
  XFillArcs := XLibrary.GetProcAddress('XFillArcs');
  XFillPolygon := XLibrary.GetProcAddress('XFillPolygon');
  XFillRectangle := XLibrary.GetProcAddress('XFillRectangle');
  XFillRectangles := XLibrary.GetProcAddress('XFillRectangles');
  XFlush := XLibrary.GetProcAddress('XFlush');
  XForceScreenSaver := XLibrary.GetProcAddress('XForceScreenSaver');
  XFree := XLibrary.GetProcAddress('XFree');
  XFreeColormap := XLibrary.GetProcAddress('XFreeColormap');
  XFreeColors := XLibrary.GetProcAddress('XFreeColors');
  XFreeCursor := XLibrary.GetProcAddress('XFreeCursor');
  XFreeExtensionList := XLibrary.GetProcAddress('XFreeExtensionList');
  XFreeFont := XLibrary.GetProcAddress('XFreeFont');
  XFreeFontInfo := XLibrary.GetProcAddress('XFreeFontInfo');
  XFreeFontNames := XLibrary.GetProcAddress('XFreeFontNames');
  XFreeFontPath := XLibrary.GetProcAddress('XFreeFontPath');
  XFreeGC := XLibrary.GetProcAddress('XFreeGC');
  XFreeModifiermap := XLibrary.GetProcAddress('XFreeModifiermap');
  XFreePixmap := XLibrary.GetProcAddress('XFreePixmap');
  XGeometry := XLibrary.GetProcAddress('XGeometry');
  XGetErrorDatabaseText := XLibrary.GetProcAddress('XGetErrorDatabaseText');
  XGetErrorText := XLibrary.GetProcAddress('XGetErrorText');
  XGetFontProperty := XLibrary.GetProcAddress('XGetFontProperty');
  XGetGCValues := XLibrary.GetProcAddress('XGetGCValues');
  XGetGeometry := XLibrary.GetProcAddress('XGetGeometry');
  XGetIconName := XLibrary.GetProcAddress('XGetIconName');
  XGetInputFocus := XLibrary.GetProcAddress('XGetInputFocus');
  XGetKeyboardControl := XLibrary.GetProcAddress('XGetKeyboardControl');
  XGetPointerControl := XLibrary.GetProcAddress('XGetPointerControl');
  XGetPointerMapping := XLibrary.GetProcAddress('XGetPointerMapping');
  XGetScreenSaver := XLibrary.GetProcAddress('XGetScreenSaver');
  XGetTransientForHint := XLibrary.GetProcAddress('XGetTransientForHint');
  XGetWindowProperty := XLibrary.GetProcAddress('XGetWindowProperty');
  XGetWindowAttributes := XLibrary.GetProcAddress('XGetWindowAttributes');
  XGrabButton := XLibrary.GetProcAddress('XGrabButton');
  XGrabKey := XLibrary.GetProcAddress('XGrabKey');
  XGrabKeyboard := XLibrary.GetProcAddress('XGrabKeyboard');
  XGrabPointer := XLibrary.GetProcAddress('XGrabPointer');
  XGrabServer := XLibrary.GetProcAddress('XGrabServer');
  XHeightMMOfScreen := XLibrary.GetProcAddress('XHeightMMOfScreen');
  XHeightOfScreen := XLibrary.GetProcAddress('XHeightOfScreen');
  XIfEvent := XLibrary.GetProcAddress('XIfEvent');
  XImageByteOrder := XLibrary.GetProcAddress('XImageByteOrder');
  XInstallColormap := XLibrary.GetProcAddress('XInstallColormap');
  XKeysymToKeycode := XLibrary.GetProcAddress('XKeysymToKeycode');
  XKillClient := XLibrary.GetProcAddress('XKillClient');
  XLookupColor := XLibrary.GetProcAddress('XLookupColor');
  XLowerWindow := XLibrary.GetProcAddress('XLowerWindow');
  XMapRaised := XLibrary.GetProcAddress('XMapRaised');
  XMapSubwindows := XLibrary.GetProcAddress('XMapSubwindows');
  XMapWindow := XLibrary.GetProcAddress('XMapWindow');
  XMaskEvent := XLibrary.GetProcAddress('XMaskEvent');
  XMaxCmapsOfScreen := XLibrary.GetProcAddress('XMaxCmapsOfScreen');
  XMinCmapsOfScreen := XLibrary.GetProcAddress('XMinCmapsOfScreen');
  XMoveResizeWindow := XLibrary.GetProcAddress('XMoveResizeWindow');
  XMoveWindow := XLibrary.GetProcAddress('XMoveWindow');
  XNextEvent := XLibrary.GetProcAddress('XNextEvent');
  XNoOp := XLibrary.GetProcAddress('XNoOp');
  XParseColor := XLibrary.GetProcAddress('XParseColor');
  XParseGeometry := XLibrary.GetProcAddress('XParseGeometry');
  XPeekEvent := XLibrary.GetProcAddress('XPeekEvent');
  XPeekIfEvent := XLibrary.GetProcAddress('XPeekIfEvent');
  XPending := XLibrary.GetProcAddress('XPending');
  XPlanesOfScreen := XLibrary.GetProcAddress('XPlanesOfScreen');
  XProtocolRevision := XLibrary.GetProcAddress('XProtocolRevision');
  XProtocolVersion := XLibrary.GetProcAddress('XProtocolVersion');
  XPutBackEvent := XLibrary.GetProcAddress('XPutBackEvent');
  XPutImage := XLibrary.GetProcAddress('XPutImage');
  XQLength := XLibrary.GetProcAddress('XQLength');
  XQueryBestCursor := XLibrary.GetProcAddress('XQueryBestCursor');
  XQueryBestSize := XLibrary.GetProcAddress('XQueryBestSize');
  XQueryBestStipple := XLibrary.GetProcAddress('XQueryBestStipple');
  XQueryBestTile := XLibrary.GetProcAddress('XQueryBestTile');
  XQueryColor := XLibrary.GetProcAddress('XQueryColor');
  XQueryColors := XLibrary.GetProcAddress('XQueryColors');
  XQueryExtension := XLibrary.GetProcAddress('XQueryExtension');
  XQueryKeymap := XLibrary.GetProcAddress('XQueryKeymap');
  XQueryPointer := XLibrary.GetProcAddress('XQueryPointer');
  XQueryTextExtents := XLibrary.GetProcAddress('XQueryTextExtents');
  XQueryTextExtents16 := XLibrary.GetProcAddress('XQueryTextExtents16');
  XQueryTree := XLibrary.GetProcAddress('XQueryTree');
  XRaiseWindow := XLibrary.GetProcAddress('XRaiseWindow');
  XReadBitmapFile := XLibrary.GetProcAddress('XReadBitmapFile');
  XReadBitmapFileData := XLibrary.GetProcAddress('XReadBitmapFileData');
  XRebindKeysym := XLibrary.GetProcAddress('XRebindKeysym');
  XRecolorCursor := XLibrary.GetProcAddress('XRecolorCursor');
  XRefreshKeyboardMapping := XLibrary.GetProcAddress('XRefreshKeyboardMapping');
  XRemoveFromSaveSet := XLibrary.GetProcAddress('XRemoveFromSaveSet');
  XRemoveHost := XLibrary.GetProcAddress('XRemoveHost');
  XRemoveHosts := XLibrary.GetProcAddress('XRemoveHosts');
  XReparentWindow := XLibrary.GetProcAddress('XReparentWindow');
  XResetScreenSaver := XLibrary.GetProcAddress('XResetScreenSaver');
  XResizeWindow := XLibrary.GetProcAddress('XResizeWindow');
  XRestackWindows := XLibrary.GetProcAddress('XRestackWindows');
  XRotateBuffers := XLibrary.GetProcAddress('XRotateBuffers');
  XRotateWindowProperties := XLibrary.GetProcAddress('XRotateWindowProperties');
  XScreenCount := XLibrary.GetProcAddress('XScreenCount');
  XSelectInput := XLibrary.GetProcAddress('XSelectInput');
  XSendEvent := XLibrary.GetProcAddress('XSendEvent');
  XSetAccessControl := XLibrary.GetProcAddress('XSetAccessControl');
  XSetArcMode := XLibrary.GetProcAddress('XSetArcMode');
  XSetBackground := XLibrary.GetProcAddress('XSetBackground');
  XSetClipMask := XLibrary.GetProcAddress('XSetClipMask');
  XSetClipOrigin := XLibrary.GetProcAddress('XSetClipOrigin');
  XSetClipRectangles := XLibrary.GetProcAddress('XSetClipRectangles');
  XSetCloseDownMode := XLibrary.GetProcAddress('XSetCloseDownMode');
  XSetCommand := XLibrary.GetProcAddress('XSetCommand');
  XSetDashes := XLibrary.GetProcAddress('XSetDashes');
  XSetFillRule := XLibrary.GetProcAddress('XSetFillRule');
  XSetFillStyle := XLibrary.GetProcAddress('XSetFillStyle');
  XSetFont := XLibrary.GetProcAddress('XSetFont');
  XSetFontPath := XLibrary.GetProcAddress('XSetFontPath');
  XSetForeground := XLibrary.GetProcAddress('XSetForeground');
  XSetFunction := XLibrary.GetProcAddress('XSetFunction');
  XSetGraphicsExposures := XLibrary.GetProcAddress('XSetGraphicsExposures');
  XSetIconName := XLibrary.GetProcAddress('XSetIconName');
  XSetInputFocus := XLibrary.GetProcAddress('XSetInputFocus');
  XSetLineAttributes := XLibrary.GetProcAddress('XSetLineAttributes');
  XSetModifierMapping := XLibrary.GetProcAddress('XSetModifierMapping');
  XSetPlaneMask := XLibrary.GetProcAddress('XSetPlaneMask');
  XSetPointerMapping := XLibrary.GetProcAddress('XSetPointerMapping');
  XSetScreenSaver := XLibrary.GetProcAddress('XSetScreenSaver');
  XSetSelectionOwner := XLibrary.GetProcAddress('XSetSelectionOwner');
  XSetState := XLibrary.GetProcAddress('XSetState');
  XSetStipple := XLibrary.GetProcAddress('XSetStipple');
  XSetSubwindowMode := XLibrary.GetProcAddress('XSetSubwindowMode');
  XSetTSOrigin := XLibrary.GetProcAddress('XSetTSOrigin');
  XSetTile := XLibrary.GetProcAddress('XSetTile');
  XSetWindowBackground := XLibrary.GetProcAddress('XSetWindowBackground');
  XSetWindowBackgroundPixmap := XLibrary.GetProcAddress('XSetWindowBackgroundPixmap');
  XSetWindowBorder := XLibrary.GetProcAddress('XSetWindowBorder');
  XSetWindowBorderPixmap := XLibrary.GetProcAddress('XSetWindowBorderPixmap');
  XSetWindowBorderWidth := XLibrary.GetProcAddress('XSetWindowBorderWidth');
  XSetWindowColormap := XLibrary.GetProcAddress('XSetWindowColormap');
  XStoreBuffer := XLibrary.GetProcAddress('XStoreBuffer');
  XStoreBytes := XLibrary.GetProcAddress('XStoreBytes');
  XStoreColor := XLibrary.GetProcAddress('XStoreColor');
  XStoreColors := XLibrary.GetProcAddress('XStoreColors');
  XStoreName := XLibrary.GetProcAddress('XStoreName');
  XStoreNamedColor := XLibrary.GetProcAddress('XStoreNamedColor');
  XSync := XLibrary.GetProcAddress('XSync');
  XTextExtents := XLibrary.GetProcAddress('XTextExtents');
  XTextExtents16 := XLibrary.GetProcAddress('XTextExtents16');
  XTextWidth := XLibrary.GetProcAddress('XTextWidth');
  XTextWidth16 := XLibrary.GetProcAddress('XTextWidth16');
  XTranslateCoordinates := XLibrary.GetProcAddress('XTranslateCoordinates');
  XUndefineCursor := XLibrary.GetProcAddress('XUndefineCursor');
  XUngrabButton := XLibrary.GetProcAddress('XUngrabButton');
  XUngrabKey := XLibrary.GetProcAddress('XUngrabKey');
  XUngrabKeyboard := XLibrary.GetProcAddress('XUngrabKeyboard');
  XUngrabPointer := XLibrary.GetProcAddress('XUngrabPointer');
  XUngrabServer := XLibrary.GetProcAddress('XUngrabServer');
  XUninstallColormap := XLibrary.GetProcAddress('XUninstallColormap');
  XUnloadFont := XLibrary.GetProcAddress('XUnloadFont');
  XUnmapSubwindows := XLibrary.GetProcAddress('XUnmapSubwindows');
  XUnmapWindow := XLibrary.GetProcAddress('XUnmapWindow');
  XVendorRelease := XLibrary.GetProcAddress('XVendorRelease');
  XWarpPointer := XLibrary.GetProcAddress('XWarpPointer');
  XWidthMMOfScreen := XLibrary.GetProcAddress('XWidthMMOfScreen');
  XWidthOfScreen := XLibrary.GetProcAddress('XWidthOfScreen');
  XWindowEvent := XLibrary.GetProcAddress('XWindowEvent');
  XWriteBitmapFile := XLibrary.GetProcAddress('XWriteBitmapFile');
  XSupportsLocale := XLibrary.GetProcAddress('XSupportsLocale');
  XSetLocaleModifiers := XLibrary.GetProcAddress('XSetLocaleModifiers');
  XOpenOM := XLibrary.GetProcAddress('XOpenOM');
  XCloseOM := XLibrary.GetProcAddress('XCloseOM');
  XDisplayOfOM := XLibrary.GetProcAddress('XDisplayOfOM');
  XLocaleOfOM := XLibrary.GetProcAddress('XLocaleOfOM');
  XDestroyOC := XLibrary.GetProcAddress('XDestroyOC');
  XOMOfOC := XLibrary.GetProcAddress('XOMOfOC');
  XCreateFontSet := XLibrary.GetProcAddress('XCreateFontSet');
  XFreeFontSet := XLibrary.GetProcAddress('XFreeFontSet');
  XFontsOfFontSet := XLibrary.GetProcAddress('XFontsOfFontSet');
  XBaseFontNameListOfFontSet := XLibrary.GetProcAddress('XBaseFontNameListOfFontSet');
  XLocaleOfFontSet := XLibrary.GetProcAddress('XLocaleOfFontSet');
  XContextDependentDrawing := XLibrary.GetProcAddress('XContextDependentDrawing');
  XDirectionalDependentDrawing := XLibrary.GetProcAddress('XDirectionalDependentDrawing');
  XContextualDrawing := XLibrary.GetProcAddress('XContextualDrawing');
  XExtentsOfFontSet := XLibrary.GetProcAddress('XExtentsOfFontSet');
  XmbTextEscapement := XLibrary.GetProcAddress('XmbTextEscapement');
  XwcTextEscapement := XLibrary.GetProcAddress('XwcTextEscapement');
  Xutf8TextEscapement := XLibrary.GetProcAddress('Xutf8TextEscapement');
  XmbTextExtents := XLibrary.GetProcAddress('XmbTextExtents');
  XwcTextExtents := XLibrary.GetProcAddress('XwcTextExtents');
  Xutf8TextExtents := XLibrary.GetProcAddress('Xutf8TextExtents');
  XmbTextPerCharExtents := XLibrary.GetProcAddress('XmbTextPerCharExtents');
  XwcTextPerCharExtents := XLibrary.GetProcAddress('XwcTextPerCharExtents');
  Xutf8TextPerCharExtents := XLibrary.GetProcAddress('Xutf8TextPerCharExtents');
  XmbDrawText := XLibrary.GetProcAddress('XmbDrawText');
  XwcDrawText := XLibrary.GetProcAddress('XwcDrawText');
  Xutf8DrawText := XLibrary.GetProcAddress('Xutf8DrawText');
  XmbDrawString := XLibrary.GetProcAddress('XmbDrawString');
  XwcDrawString := XLibrary.GetProcAddress('XwcDrawString');
  Xutf8DrawString := XLibrary.GetProcAddress('Xutf8DrawString');
  XmbDrawImageString := XLibrary.GetProcAddress('XmbDrawImageString');
  XwcDrawImageString := XLibrary.GetProcAddress('XwcDrawImageString');
  Xutf8DrawImageString := XLibrary.GetProcAddress('Xutf8DrawImageString');
  XOpenIM := XLibrary.GetProcAddress('XOpenIM');
  XCloseIM := XLibrary.GetProcAddress('XCloseIM');
  XDisplayOfIM := XLibrary.GetProcAddress('XDisplayOfIM');
  XLocaleOfIM := XLibrary.GetProcAddress('XLocaleOfIM');
  XDestroyIC := XLibrary.GetProcAddress('XDestroyIC');
  XSetICFocus := XLibrary.GetProcAddress('XSetICFocus');
  XUnsetICFocus := XLibrary.GetProcAddress('XUnsetICFocus');
  XwcResetIC := XLibrary.GetProcAddress('XwcResetIC');
  XmbResetIC := XLibrary.GetProcAddress('XmbResetIC');
  Xutf8ResetIC := XLibrary.GetProcAddress('Xutf8ResetIC');

  Result :=
	  assigned(_Xmblen) and
	  assigned(XLoadQueryFont) and
	  assigned(XQueryFont) and
	  assigned(XGetMotionEvents) and
	  assigned(XDeleteModifiermapEntry) and
	  assigned(XGetModifierMapping) and
	  assigned(XInsertModifiermapEntry) and
	  assigned(XNewModifiermap) and
	  assigned(XCreateImage) and
	  assigned(XInitImage) and
	  assigned(XGetImage) and
	  assigned(XGetSubImage) and
	  assigned(XOpenDisplay) and
	  assigned(XrmInitialize) and
	  assigned(XFetchBytes) and
	  assigned(XFetchBuffer) and
	  assigned(XGetAtomName) and
	  assigned(XGetAtomNames) and
	  assigned(XGetDefault) and
	  assigned(XDisplayName) and
	  assigned(XKeysymToString) and
	  assigned(XSynchronize) and
	  assigned(XSetAfterFunction) and
	  assigned(XInternAtom) and
	  assigned(XInternAtoms) and
	  assigned(XCopyColormapAndFree) and
	  assigned(XCreateColormap) and
	  assigned(XCreatePixmapCursor) and
	  assigned(XCreateGlyphCursor) and
	  assigned(XCreateFontCursor) and
	  assigned(XLoadFont) and
	  assigned(XCreateGC) and
	  assigned(XGContextFromGC) and
	  assigned(XFlushGC) and
	  assigned(XCreatePixmap) and
	  assigned(XCreateBitmapFromData) and
	  assigned(XCreatePixmapFromBitmapData) and
	  assigned(XCreateSimpleWindow) and
	  assigned(XGetSelectionOwner) and
	  assigned(XCreateWindow) and
	  assigned(XListInstalledColormaps) and
	  assigned(XListProperties) and
	  assigned(XListHosts) and
	  assigned(XKeycodeToKeysym) and
//    assigned(XLookupKeysym) and
	  assigned(XGetKeyboardMapping) and
	  assigned(XStringToKeysym) and
	  assigned(XMaxRequestSize) and
	  assigned(XExtendedMaxRequestSize) and
	  assigned(XResourceManagerString) and
	  assigned(XScreenResourceString) and
	  assigned(XDisplayMotionBufferSize) and
	  assigned(XVisualIDFromVisual) and
	  assigned(XInitThreads) and
	  assigned(XLockDisplay) and
	  assigned(XUnlockDisplay) and
	  assigned(XInitExtension) and
	  assigned(XAddExtension) and
	  assigned(XFindOnExtensionList) and
	  assigned(XRootWindow) and
	  assigned(XDefaultRootWindow) and
	  assigned(XRootWindowOfScreen) and
	  assigned(XDefaultVisual) and
	  assigned(XDefaultVisualOfScreen) and
	  assigned(XDefaultGC) and
	  assigned(XDefaultGCOfScreen) and
	  assigned(XBlackPixel) and
	  assigned(XWhitePixel) and
	  assigned(XAllPlanes) and
	  assigned(XBlackPixelOfScreen) and
	  assigned(XWhitePixelOfScreen) and
	  assigned(XNextRequest) and
	  assigned(XLastKnownRequestProcessed) and
	  assigned(XServerVendor) and
	  assigned(XDisplayString) and
	  assigned(XDefaultColormap) and
	  assigned(XDefaultColormapOfScreen) and
	  assigned(XDisplayOfScreen) and
	  assigned(XScreenOfDisplay) and
	  assigned(XDefaultScreenOfDisplay) and
	  assigned(XEventMaskOfScreen) and
	  assigned(XScreenNumberOfScreen) and
	  assigned(XSetErrorHandler) and
	  assigned(XSetIOErrorHandler) and
	  assigned(XListPixmapFormats) and
	  assigned(XListDepths) and
	  assigned(XReconfigureWMWindow) and
	  assigned(XGetWMProtocols) and
	  assigned(XSetWMProtocols) and
	  assigned(XIconifyWindow) and
	  assigned(XWithdrawWindow) and
	  assigned(XGetCommand) and
	  assigned(XGetWMColormapWindows) and
	  assigned(XSetWMColormapWindows) and
	  assigned(XFreeStringList) and
	  assigned(XSetTransientForHint) and
	  assigned(XActivateScreenSaver) and
	  assigned(XAddHost) and
	  assigned(XAddHosts) and
	  assigned(XAddToExtensionList) and
	  assigned(XAddToSaveSet) and
	  assigned(XAllocColor) and
	  assigned(XAllocColorCells) and
	  assigned(XAllocColorPlanes) and
	  assigned(XAllocNamedColor) and
	  assigned(XAllowEvents) and
	  assigned(XAutoRepeatOff) and
	  assigned(XAutoRepeatOn) and
	  assigned(XBell) and
	  assigned(XBitmapBitOrder) and
	  assigned(XBitmapPad) and
	  assigned(XBitmapUnit) and
	  assigned(XCellsOfScreen) and
	  assigned(XChangeActivePointerGrab) and
	  assigned(XChangeGC) and
	  assigned(XChangeKeyboardControl) and
	  assigned(XChangeKeyboardMapping) and
	  assigned(XChangePointerControl) and
	  assigned(XChangeProperty) and
	  assigned(XChangeSaveSet) and
	  assigned(XChangeWindowAttributes) and
	  assigned(XCheckIfEvent) and
	  assigned(XCheckMaskEvent) and
	  assigned(XCheckTypedEvent) and
	  assigned(XCheckTypedWindowEvent) and
	  assigned(XCheckWindowEvent) and
	  assigned(XCirculateSubwindows) and
	  assigned(XCirculateSubwindowsDown) and
	  assigned(XCirculateSubwindowsUp) and
	  assigned(XClearArea) and
	  assigned(XClearWindow) and
	  assigned(XCloseDisplay) and
	  assigned(XConfigureWindow) and
	  assigned(XConnectionNumber) and
	  assigned(XConvertSelection) and
	  assigned(XCopyArea) and
	  assigned(XCopyGC) and
	  assigned(XCopyPlane) and
	  assigned(XDefaultDepth) and
	  assigned(XDefaultDepthOfScreen) and
	  assigned(XDefaultScreen) and
	  assigned(XDefineCursor) and
	  assigned(XDeleteProperty) and
	  assigned(XDestroyWindow) and
	  assigned(XDestroySubwindows) and
	  assigned(XDoesBackingStore) and
	  assigned(XDoesSaveUnders) and
	  assigned(XDisableAccessControl) and
	  assigned(XDisplayCells) and
	  assigned(XDisplayHeight) and
	  assigned(XDisplayHeightMM) and
	  assigned(XDisplayKeycodes) and
	  assigned(XDisplayPlanes) and
	  assigned(XDisplayWidth) and
	  assigned(XDisplayWidthMM) and
	  assigned(XDrawArc) and
	  assigned(XDrawArcs) and
	  assigned(XDrawImageString) and
	  assigned(XDrawImageString16) and
	  assigned(XDrawLine) and
	  assigned(XDrawLines) and
	  assigned(XDrawPoint) and
	  assigned(XDrawPoints) and
	  assigned(XDrawRectangle) and
	  assigned(XDrawRectangles) and
	  assigned(XDrawSegments) and
	  assigned(XDrawString) and
	  assigned(XDrawString16) and
	  assigned(XDrawText) and
	  assigned(XDrawText16) and
	  assigned(XEnableAccessControl) and
	  assigned(XEventsQueued) and
	  assigned(XFetchName) and
	  assigned(XFillArc) and
	  assigned(XFillArcs) and
	  assigned(XFillPolygon) and
	  assigned(XFillRectangle) and
	  assigned(XFillRectangles) and
	  assigned(XFlush) and
	  assigned(XForceScreenSaver) and
	  assigned(XFree) and
	  assigned(XFreeColormap) and
	  assigned(XFreeColors) and
	  assigned(XFreeCursor) and
	  assigned(XFreeExtensionList) and
	  assigned(XFreeFont) and
	  assigned(XFreeFontInfo) and
	  assigned(XFreeFontNames) and
	  assigned(XFreeFontPath) and
	  assigned(XFreeGC) and
	  assigned(XFreeModifiermap) and
	  assigned(XFreePixmap) and
	  assigned(XGeometry) and
	  assigned(XGetErrorDatabaseText) and
	  assigned(XGetErrorText) and
	  assigned(XGetFontProperty) and
	  assigned(XGetGCValues) and
	  assigned(XGetGeometry) and
	  assigned(XGetIconName) and
	  assigned(XGetInputFocus) and
	  assigned(XGetKeyboardControl) and
	  assigned(XGetPointerControl) and
	  assigned(XGetPointerMapping) and
	  assigned(XGetScreenSaver) and
	  assigned(XGetTransientForHint) and
	  assigned(XGetWindowProperty) and
	  assigned(XGetWindowAttributes) and
	  assigned(XGrabButton) and
	  assigned(XGrabKey) and
	  assigned(XGrabKeyboard) and
	  assigned(XGrabPointer) and
	  assigned(XGrabServer) and
	  assigned(XHeightMMOfScreen) and
	  assigned(XHeightOfScreen) and
	  assigned(XIfEvent) and
	  assigned(XImageByteOrder) and
	  assigned(XInstallColormap) and
	  assigned(XKeysymToKeycode) and
	  assigned(XKillClient) and
	  assigned(XLookupColor) and
	  assigned(XLowerWindow) and
	  assigned(XMapRaised) and
	  assigned(XMapSubwindows) and
	  assigned(XMapWindow) and
	  assigned(XMaskEvent) and
	  assigned(XMaxCmapsOfScreen) and
	  assigned(XMinCmapsOfScreen) and
	  assigned(XMoveResizeWindow) and
	  assigned(XMoveWindow) and
	  assigned(XNextEvent) and
	  assigned(XNoOp) and
	  assigned(XParseColor) and
	  assigned(XParseGeometry) and
	  assigned(XPeekEvent) and
	  assigned(XPeekIfEvent) and
	  assigned(XPending) and
	  assigned(XPlanesOfScreen) and
	  assigned(XProtocolRevision) and
	  assigned(XProtocolVersion) and
	  assigned(XPutBackEvent) and
	  assigned(XPutImage) and
	  assigned(XQLength) and
	  assigned(XQueryBestCursor) and
	  assigned(XQueryBestSize) and
	  assigned(XQueryBestStipple) and
	  assigned(XQueryBestTile) and
	  assigned(XQueryColor) and
	  assigned(XQueryColors) and
	  assigned(XQueryExtension) and
	  assigned(XQueryKeymap) and
	  assigned(XQueryPointer) and
	  assigned(XQueryTextExtents) and
	  assigned(XQueryTextExtents16) and
	  assigned(XQueryTree) and
	  assigned(XRaiseWindow) and
	  assigned(XReadBitmapFile) and
	  assigned(XReadBitmapFileData) and
	  assigned(XRebindKeysym) and
	  assigned(XRecolorCursor) and
	  assigned(XRefreshKeyboardMapping) and
	  assigned(XRemoveFromSaveSet) and
	  assigned(XRemoveHost) and
	  assigned(XRemoveHosts) and
	  assigned(XReparentWindow) and
	  assigned(XResetScreenSaver) and
	  assigned(XResizeWindow) and
	  assigned(XRestackWindows) and
	  assigned(XRotateBuffers) and
	  assigned(XRotateWindowProperties) and
	  assigned(XScreenCount) and
	  assigned(XSelectInput) and
	  assigned(XSendEvent) and
	  assigned(XSetAccessControl) and
	  assigned(XSetArcMode) and
	  assigned(XSetBackground) and
	  assigned(XSetClipMask) and
	  assigned(XSetClipOrigin) and
	  assigned(XSetClipRectangles) and
	  assigned(XSetCloseDownMode) and
	  assigned(XSetCommand) and
	  assigned(XSetDashes) and
	  assigned(XSetFillRule) and
	  assigned(XSetFillStyle) and
	  assigned(XSetFont) and
	  assigned(XSetFontPath) and
	  assigned(XSetForeground) and
	  assigned(XSetFunction) and
	  assigned(XSetGraphicsExposures) and
	  assigned(XSetIconName) and
	  assigned(XSetInputFocus) and
	  assigned(XSetLineAttributes) and
	  assigned(XSetModifierMapping) and
	  assigned(XSetPlaneMask) and
	  assigned(XSetPointerMapping) and
	  assigned(XSetScreenSaver) and
	  assigned(XSetSelectionOwner) and
	  assigned(XSetState) and
	  assigned(XSetStipple) and
	  assigned(XSetSubwindowMode) and
	  assigned(XSetTSOrigin) and
	  assigned(XSetTile) and
	  assigned(XSetWindowBackground) and
	  assigned(XSetWindowBackgroundPixmap) and
	  assigned(XSetWindowBorder) and
	  assigned(XSetWindowBorderPixmap) and
	  assigned(XSetWindowBorderWidth) and
	  assigned(XSetWindowColormap) and
	  assigned(XStoreBuffer) and
	  assigned(XStoreBytes) and
	  assigned(XStoreColor) and
	  assigned(XStoreColors) and
	  assigned(XStoreName) and
	  assigned(XStoreNamedColor) and
	  assigned(XSync) and
	  assigned(XTextExtents) and
	  assigned(XTextExtents16) and
	  assigned(XTextWidth) and
	  assigned(XTextWidth16) and
	  assigned(XTranslateCoordinates) and
	  assigned(XUndefineCursor) and
	  assigned(XUngrabButton) and
	  assigned(XUngrabKey) and
	  assigned(XUngrabKeyboard) and
	  assigned(XUngrabPointer) and
	  assigned(XUngrabServer) and
	  assigned(XUninstallColormap) and
	  assigned(XUnloadFont) and
	  assigned(XUnmapSubwindows) and
	  assigned(XUnmapWindow) and
	  assigned(XVendorRelease) and
	  assigned(XWarpPointer) and
	  assigned(XWidthMMOfScreen) and
	  assigned(XWidthOfScreen) and
	  assigned(XWindowEvent) and
	  assigned(XWriteBitmapFile) and
	  assigned(XSupportsLocale) and
	  assigned(XSetLocaleModifiers) and
	  assigned(XOpenOM) and
	  assigned(XCloseOM) and
	  assigned(XDisplayOfOM) and
	  assigned(XLocaleOfOM) and
	  assigned(XDestroyOC) and
	  assigned(XOMOfOC) and
	  assigned(XCreateFontSet) and
	  assigned(XFreeFontSet) and
	  assigned(XFontsOfFontSet) and
	  assigned(XBaseFontNameListOfFontSet) and
	  assigned(XLocaleOfFontSet) and
	  assigned(XContextDependentDrawing) and
	  assigned(XDirectionalDependentDrawing) and
	  assigned(XContextualDrawing) and
	  assigned(XExtentsOfFontSet) and
	  assigned(XmbTextEscapement) and
	  assigned(XwcTextEscapement) and
	  assigned(Xutf8TextEscapement) and
	  assigned(XmbTextExtents) and
	  assigned(XwcTextExtents) and
	  assigned(Xutf8TextExtents) and
	  assigned(XmbTextPerCharExtents) and
	  assigned(XwcTextPerCharExtents) and
	  assigned(Xutf8TextPerCharExtents) and
	  assigned(XmbDrawText) and
	  assigned(XwcDrawText) and
	  assigned(Xutf8DrawText) and
	  assigned(XmbDrawString) and
	  assigned(XwcDrawString) and
	  assigned(Xutf8DrawString) and
	  assigned(XmbDrawImageString) and
	  assigned(XwcDrawImageString) and
	  assigned(Xutf8DrawImageString) and
	  assigned(XOpenIM) and
	  assigned(XCloseIM) and
	  assigned(XDisplayOfIM) and
	  assigned(XLocaleOfIM) and
	  assigned(XDestroyIC) and
	  assigned(XSetICFocus) and
	  assigned(XUnsetICFocus) and
	  assigned(XwcResetIC) and
	  assigned(XmbResetIC) and
	  assigned(Xutf8ResetIC);
end;

initialization
  if not assigned(XLibrary) then begin
    XLibrary := TDynLib.Create;
  end;
  if not XLibrary.LoadLibrary( cLibName ) then begin
    raise Exception.Create('Failed to load library: '+cLibName);
  end;
  if not LoadEntryPoints then begin
    raise Exception.Create('Failed to locate entry points into: '+cLibName);
  end;

finalization
  XLibrary := nil;

end.
