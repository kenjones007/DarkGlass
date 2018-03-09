(* Definitions for the X window system likely to be used by applications *)
(***********************************************************

Copyright 1987, 1998  The Open Group

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


Copyright 1987 by Digital Equipment Corporation, Maynard, Massachusetts.

                        All Rights Reserved

Permission to use, copy, modify, and distribute this software and its
documentation for any purpose and without fee is hereby granted,
provided that the above copyright notice appear in all copies and that
both that copyright notice and this permission notice appear in
supporting documentation, and that the name of Digital not be
used in advertising or publicity pertaining to distribution of the
software without specific, written prior permission.

DIGITAL DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING
ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL
DIGITAL BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR
ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
SOFTWARE.

******************************************************************)
(*
    Translation for Delphi by Craig Chapman
*)
unit dg.platform.linux.binding.x;

interface

(*****************************************************************
 * ERROR CODES
 *****************************************************************)

const
              Success = 0;	(* everything's okay *)
           BadRequest = 1;	(* bad request code *)
             BadValue = 2;	(* int parameter out of range *)
            BadWindow = 3;	(* parameter not a Window *)
            BadPixmap = 4;	(* parameter not a Pixmap *)
              BadAtom = 5;	(* parameter not an Atom *)
            BadCursor = 6;	(* parameter not a Cursor *)
              BadFont = 7;	(* parameter not a Font *)
             BadMatch = 8;	(* parameter mismatch *)
          BadDrawable = 9;	(* parameter not a Pixmap or Window *)
            BadAccess = 10;	(* depending on context:
                      				 - key/button already grabbed
                      				 - attempt to free an illegal cmap entry
                               - attempt to store into a read-only color map entry.
                               - attempt to modify the access control list from other than the local host. *)
             BadAlloc = 11;	(* insufficient resources *)
             BadColor = 12;	(* no such colormap *)
                BadGC = 13;	 (* parameter not a GC *)
          BadIDChoice = 14;	(* choice not in range or already used *)
              BadName = 15;	(* font or color name doesn't exist *)
            BadLength = 16;	(* Request length incorrect *)
    BadImplementation = 17;	(* server is defective *)
  FirstExtensionError = 128;
  LastExtensionError  = 255;

(*****************************************************************
 * WINDOW DEFINITIONS
 *****************************************************************)

(* Window classes used by CreateWindow *)
(* Note that CopyFromParent is already defined as 0 above *)

const
  InputOutput = 1;
  InputOnly   =	2;

(* Window attributes for CreateWindow and ChangeWindowAttributes *)
const
        CWBackPixmap = 1 shl 0;
         CWBackPixel = 1 shl 1;
      CWBorderPixmap = 1 shl 2;
       CWBorderPixel = 1 shl 3;
        CWBitGravity = 1 shl 4;
        CWWinGravity = 1 shl 5;
      CWBackingStore = 1 shl 6;
     CWBackingPlanes = 1 shl 7;
      CWBackingPixel = 1 shl 8;
  CWOverrideRedirect = 1 shl 9;
         CWSaveUnder = 1 shl 10;
         CWEventMask = 1 shl 11;
     CWDontPropagate = 1 shl 12;
          CWColormap = 1 shl 13;
            CWCursor = 1 shl 14;


(* ConfigureWindow structure *)

const
            CWX = 1 shl 0;
            CWY = 1 shl 1;
        CWWidth = 1 shl 2;
       CWHeight = 1 shl 3;
  CWBorderWidth = 1 shl 4;
      CWSibling = 1 shl 5;
    CWStackMode = 1 shl 6;


(* Bit Gravity *)

const
     ForgetGravity = 0;
  NorthWestGravity = 1;
      NorthGravity = 2;
  NorthEastGravity = 3;
       WestGravity = 4;
     CenterGravity = 5;
       EastGravity = 6;
  SouthWestGravity = 7;
      SouthGravity = 8;
  SouthEastGravity = 9;
     StaticGravity = 10;

(* Window gravity + bit gravity above *)

const
  UnmapGravity = 0;

(* Used in CreateWindow for backing-store hint *)

const
   NotUseful = 0;
  WhenMapped = 1;
      Always = 2;

(* Used in GetWindowAttributes reply *)

const
    IsUnmapped = 0;
  IsUnviewable = 1;
    IsViewable = 2;

(* Used in ChangeSaveSet *)

const
  SetModeInsert = 0;
  SetModeDelete = 1;

(* Used in ChangeCloseDownMode *)

const
       DestroyAll = 0;
  RetainPermanent = 1;
  RetainTemporary = 2;

(* Window stacking method (in configureWindow) *)

const
     Above = 0;
     Below = 1;
     TopIf = 2;
  BottomIf = 3;
  Opposite = 4;

(* Circulation direction *)

const
   RaiseLowest = 0;
  LowerHighest = 1;

(* Property modes *)

const
  PropModeReplace = 0;
  PropModePrepend = 1;
   PropModeAppend = 2;


(*****************************************************************
 * RESERVED RESOURCE AND CONSTANT DEFINITIONS
 *****************************************************************)

const
  None = 0;

  ParentRelative = 1;	(* background pixmap in CreateWindow and ChangeWindowAttributes *)
  CopyFromParent = 0;	(* border pixmap in CreateWindow and ChangeWindowAttributes
                     				     special VisualID and special window class passed to CreateWindow *)
   PointerWindow = 0;	(* destination window in SendEvent *)
      InputFocus = 1;	(* destination window in SendEvent *)
     PointerRoot = 1;	(* focus window in SetInputFocus *)
 AnyPropertyType = 0;	(* special Atom, passed to GetProperty *)
          AnyKey = 0;	(* special Key Code, passed to GrabKey *)
       AnyButton = 0;	(* special Button Code, passed to GrabButton *)
    AllTemporary = 0;	(* special Resource ID passed to KillClient *)
     CurrentTime = 0;	(* special Time *)
        NoSymbol = 0;	(* special KeySym *)

(*****************************************************************
 * EVENT DEFINITIONS
 *****************************************************************)

(* Input Event Masks. Used as event-mask window attribute and as arguments
   to Grab requests.  Not to be confused with event names.  *)
const
               NoEventMask = 0;
              KeyPressMask = 1 shl 0;
            KeyReleaseMask = 1 shl 1;
           ButtonPressMask = 1 shl 2;
         ButtonReleaseMask = 1 shl 3;
           EnterWindowMask = 1 shl 4;
           LeaveWindowMask = 1 shl 5;
         PointerMotionMask = 1 shl 6;
     PointerMotionHintMask = 1 shl 7;
         Button1MotionMask = 1 shl 8;
         Button2MotionMask = 1 shl 9;
         Button3MotionMask = 1 shl 10;
         Button4MotionMask = 1 shl 11;
         Button5MotionMask = 1 shl 12;
          ButtonMotionMask = 1 shl 13;
           KeymapStateMask = 1 shl 14;
              ExposureMask = 1 shl 15;
      VisibilityChangeMask = 1 shl 16;
       StructureNotifyMask = 1 shl 17;
        ResizeRedirectMask = 1 shl 18;
    SubstructureNotifyMask = 1 shl 19;
  SubstructureRedirectMask = 1 shl 20;
           FocusChangeMask = 1 shl 21;
        PropertyChangeMask = 1 shl 22;
        ColormapChangeMask = 1 shl 23;
       OwnerGrabButtonMask = 1 shl 24;

(* Event names.  Used in "type" field in XEvent structures.  Not to be
confused with event masks above.  They start from 2 because 0 and 1
are reserved in the protocol for errors and replies. *)

const
          KeyPress = 2;
        KeyRelease = 3;
       ButtonPress = 4;
     ButtonRelease = 5;
      MotionNotify = 6;
       EnterNotify = 7;
       LeaveNotify = 8;
           FocusIn = 9;
          FocusOut = 10;
      KeymapNotify = 11;
            Expose = 12;
    GraphicsExpose = 13;
          NoExpose = 14;
  VisibilityNotify = 15;
      CreateNotify = 16;
     DestroyNotify = 17;
       UnmapNotify = 18;
         MapNotify = 19;
        MapRequest = 20;
    ReparentNotify = 21;
   ConfigureNotify = 22;
  ConfigureRequest = 23;
     GravityNotify = 24;
     ResizeRequest = 25;
   CirculateNotify = 26;
  CirculateRequest = 27;
    PropertyNotify = 28;
    SelectionClear = 29;
  SelectionRequest = 30;
   SelectionNotify = 31;
    ColormapNotify = 32;
     ClientMessage = 33;
     MappingNotify = 34;
      GenericEvent = 35;
         LASTEvent = 36;	(* must be bigger than any event # *)


(* Key masks. Used as modifiers to GrabButton and GrabKey, results of QueryPointer,
   state in various key-, mouse-, and button-related events. *)

const
    ShiftMask = 1 shl 0;
     LockMask = 1 shl 1;
  ControlMask = 1 shl 2;
     Mod1Mask = 1 shl 3;
     Mod2Mask = 1 shl 4;
     Mod3Mask = 1 shl 5;
     Mod4Mask = 1 shl 6;
     Mod5Mask = 1 shl 7;

(* modifier names.  Used to build a SetModifierMapping request or
   to read a GetModifierMapping request.  These correspond to the
   masks defined above. *)
const
    ShiftMapIndex	= 0;
     LockMapIndex = 1;
  ControlMapIndex = 2;
     Mod1MapIndex = 3;
     Mod2MapIndex = 4;
     Mod3MapIndex = 5;
     Mod4MapIndex = 6;
     Mod5MapIndex = 7;


(* button masks.  Used in same manner as Key masks above. Not to be confused
   with button names below. *)

const
  Button1Mask = 1 shl 8;
  Button2Mask = 1 shl 9;
  Button3Mask = 1 shl 10;
  Button4Mask = 1 shl 11;
  Button5Mask = 1 shl 12;
  AnyModifier = 1 shl 15;  (* used in GrabButton, GrabKey *)


(* button names. Used as arguments to GrabButton and as detail in ButtonPress
   and ButtonRelease events.  Not to be confused with button masks above.
   Note that 0 is already defined above as "AnyButton".  *)

const
  Button1 = 1;
  Button2 = 2;
  Button3 = 3;
  Button4 = 4;
  Button5 = 5;

(* Notify modes *)
const
        NotifyNormal = 0;
          NotifyGrab = 1;
        NotifyUngrab = 2;
  NotifyWhileGrabbed = 3;
          NotifyHint = 1;	(* for MotionNotify events *)

(* Notify detail *)

const
          NotifyAncestor = 0;
           NotifyVirtual = 1;
          NotifyInferior = 2;
         NotifyNonlinear = 3;
  NotifyNonlinearVirtual = 4;
           NotifyPointer = 5;
       NotifyPointerRoot = 6;
        NotifyDetailNone = 7;

(* Visibility notify *)

const
         VisibilityUnobscured = 0;
  VisibilityPartiallyObscured = 1;
      VisibilityFullyObscured = 2;

(* Circulation request *)

const
     PlaceOnTop = 0;
  PlaceOnBottom = 1;

(* protocol families *)

const
   FamilyInternet = 0;	(* IPv4 *)
     FamilyDECnet = 1;
      FamilyChaos = 2;
  FamilyInternet6 = 6;	(* IPv6 *)

(* authentication families not tied to a specific protocol *)
const
  FamilyServerInterpreted = 5;

(* Property notification *)

const
  PropertyNewValue = 0;
    PropertyDelete = 1;

(* Color Map notification *)

const
  ColormapUninstalled = 0;
  ColormapInstalled = 1;

(* GrabPointer, GrabButton, GrabKeyboard, GrabKey Modes *)

const
   GrabModeSync = 0;
  GrabModeAsync = 1;

(* GrabPointer, GrabKeyboard reply status *)

const
      GrabSuccess = 0;
   AlreadyGrabbed = 1;
  GrabInvalidTime = 2;
  GrabNotViewable = 3;
       GrabFrozen = 4;

(* AllowEvents modes *)

const
    AsyncPointer = 0;
     SyncPointer = 1;
   ReplayPointer = 2;
   AsyncKeyboard = 3;
    SyncKeyboard = 4;
  ReplayKeyboard = 5;
       AsyncBoth = 6;
        SyncBoth = 7;

(* Used in SetInputFocus, GetInputFocus *)

const
         RevertToNone: int32 = None;
  RevertToPointerRoot: int32 = 1; // PointerRoot is uint32 and cannot be cast during constant declaration, so simply using the constant value (1)
              RevertToParent = 2;



(*****************************************************************
 * GRAPHICS DEFINITIONS
 *****************************************************************)

(* graphics functions, as in GC.alu *)

const
         GXclear = $00;		(* 0 *)
           GXand = $01;		(* src AND dst *)
    GXandReverse = $02;		(* src AND NOT dst *)
          GXcopy = $03;		(* src *)
   GXandInverted = $04;		(* NOT src AND dst *)
          GXnoop = $05;		(* dst *)
           GXxor = $06;		(* src XOR dst *)
            GXor = $07;		(* src OR dst *)
           GXnor = $08;		(* NOT src AND NOT dst *)
         GXequiv = $09;		(* NOT src XOR dst *)
        GXinvert = $0a;		(* NOT dst *)
     GXorReverse = $0b;		(* src OR NOT dst *)
  GXcopyInverted = $0c;		(* NOT src *)
    GXorInverted = $0d;		(* NOT src OR dst *)
          GXnand = $0e;		(* NOT src OR NOT dst *)
           GXset = $0f;		(* 1 *)

(* LineStyle *)

const
       LineSolid = 0;
   LineOnOffDash = 1;
  LineDoubleDash = 2;

(* capStyle *)

const
     CapNotLast = 0;
        CapButt = 1;
       CapRound = 2;
  CapProjecting = 3;

(* joinStyle *)

const
  JoinMiter = 0;
  JoinRound = 1;
  JoinBevel = 2;

(* fillStyle *)

const
           FillSolid = 0;
           FillTiled = 1;
        FillStippled = 2;
  FillOpaqueStippled = 3;

(* fillRule *)

const
  EvenOddRule = 0;
  WindingRule = 1;

(* subwindow mode *)

const
    ClipByChildren = 0;
  IncludeInferiors = 1;

(* SetClipRectangles ordering *)

const
  Unsorted = 0;
   YSorted = 1;
  YXSorted = 2;
  YXBanded = 3;

(* CoordinateMode for drawing routines *)

const
    CoordModeOrigin = 0;	(* relative to the origin *)
  CoordModePrevious = 1;	(* relative to previous point *)

(* Polygon shapes *)

const
    Complex = 0;	(* paths may intersect *)
  Nonconvex = 1;	(* no paths intersect, but not convex *)
     Convex = 2;	(* wholly convex *)

(* Arc modes for PolyFillArc *)

const
     ArcChord = 0;	(* join endpoints of arc *)
  ArcPieSlice = 1;	(* join endpoints to center of arc *)

(* GC components: masks used in CreateGC, CopyGC, ChangeGC, OR'ed into
   GC.stateChanges *)

const
           GCFunction = 1 shl 0;
          GCPlaneMask = 1 shl 1;
         GCForeground = 1 shl 2;
         GCBackground = 1 shl 3;
          GCLineWidth = 1 shl 4;
          GCLineStyle = 1 shl 5;
           GCCapStyle = 1 shl 6;
          GCJoinStyle = 1 shl 7;
          GCFillStyle = 1 shl 8;
           GCFillRule = 1 shl 9;
               GCTile = 1 shl 10;
            GCStipple = 1 shl 11;
    GCTileStipXOrigin = 1 shl 12;
    GCTileStipYOrigin = 1 shl 13;
               GCFont = 1 shl 14;
      GCSubwindowMode = 1 shl 15;
  GCGraphicsExposures = 1 shl 16;
        GCClipXOrigin = 1 shl 17;
        GCClipYOrigin = 1 shl 18;
           GCClipMask = 1 shl 19;
         GCDashOffset = 1 shl 20;
           GCDashList = 1 shl 21;
            GCArcMode = 1 shl 22;

const
  GCLastBit = 22;

(*****************************************************************
 * FONTS
 *****************************************************************)

(* used in QueryFont -- draw direction *)

const
 FontLeftToRight = 0;
 FontRightToLeft = 1;
      FontChange = 255;

(*****************************************************************
 *  IMAGING
 *****************************************************************)

(* ImageFormat -- PutImage, GetImage *)
const
  XYBitmap = 0;	(* depth 1, XYFormat *)
  XYPixmap = 1;	(* depth == drawable depth *)
   ZPixmap = 2;	(* depth == drawable depth *)

(*****************************************************************
 *  COLOR MAP STUFF
 *****************************************************************)

(* For CreateColormap *)

const
  AllocNone = 0; (* create map with no entries *)
   AllocAll = 1; (* allocate entire map writeable *)


(* Flags used in StoreNamedColor, StoreColors *)

const
    DoRed = 1 shl 0;
  DoGreen = 1 shl 1;
   DoBlue = 1 shl 2;

(*****************************************************************
 * CURSOR STUFF
 *****************************************************************)

(* QueryBestSize Class *)

const
   CursorShape = 0;	(* largest size that can be displayed *)
     TileShape = 1;	(* size tiled fastest *)
  StippleShape = 2;	(* size stippled fastest *)

(*****************************************************************
 * KEYBOARD/POINTER STUFF
 *****************************************************************)

const
      AutoRepeatModeOff = 0;
       AutoRepeatModeOn = 1;
  AutoRepeatModeDefault = 2;
             LedModeOff = 0;
              LedModeOn = 1;

(* masks for ChangeKeyboardControl *)

const
  KBKeyClickPercent = 1 shl 0;
      KBBellPercent = 1 shl 1;
        KBBellPitch = 1 shl 2;
     KBBellDuration = 1 shl 3;
              KBLed = 1 shl 4;
          KBLedMode = 1 shl 5;
              KBKey = 1 shl 6;
   KBAutoRepeatMode = 1 shl 7;

const
   MappingSuccess = 0;
      MappingBusy = 1;
    MappingFailed = 2;
  MappingModifier = 0;
  MappingKeyboard = 1;
   MappingPointer = 2;

(*****************************************************************
 * SCREEN SAVER STUFF
 *****************************************************************)

const
     DontPreferBlanking = 0;
         PreferBlanking = 1;
        DefaultBlanking = 2;
     DisableScreenSaver = 0;
  DisableScreenInterval = 0;
     DontAllowExposures = 0;
         AllowExposures = 1;
       DefaultExposures = 2;

(* for ForceScreenSaver *)

const
   ScreenSaverReset = 0;
  ScreenSaverActive = 1;

(*****************************************************************
 * HOSTS AND CONNECTIONS
 *****************************************************************)

(* for ChangeHosts *)

const
  HostInsert = 0;
  HostDelete = 1;

(* for ChangeAccessControl *)

const
   EnableAccess = 1;
  DisableAccess = 0;

(* Display classes  used in opening the connection
 * Note that the statically allocated ones are even numbered and the
 * dynamically changeable ones are odd numbered *)

const
   StaticGray = 0;
    GrayScale = 1;
  StaticColor = 2;
  PseudoColor = 3;
    TrueColor = 4;
  DirectColor = 5;

(* Byte order  used in imageByteOrder and bitmapBitOrder *)

const
  LSBFirst = 0;
  MSBFirst = 1;


type
     ulong = nativeuint;
      XID  = ulong;
      PXID = ^XID;
      Mask = ulong;
      Atom = ulong;		(* Also in Xdefs.h *)
  VisualID = ulong;
      Time = ulong;
     Window = XID;
    pWindow = ^Window;
   Drawable = XID;
       Font = XID;
     Pixmap = XID;
     Cursor = XID;
   Colormap = XID;
   GContext = XID;
     KeySym = XID;
    KeyCode = uint8;


implementation

end.

