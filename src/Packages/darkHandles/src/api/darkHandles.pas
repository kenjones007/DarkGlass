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
unit darkHandles;

interface

type
  ///  <summary>
  ///    A handle to an object within the darkglass system.
  ///  </summary>
  THandle = pointer;

  ///  <summary>
  ///    Indicates the kind of handle to be created with a call to CreateHandle
  ///  </summary>
  THandleKind = (
    hkMessagePipe
  );

  ///  <summary>
  ///    A callback method capable of freeing a given handle and it's
  ///    associated objects.
  ///  </summary>
  THandleFreeMethod = procedure( Instance: IInterface ) of object;

  ///  <summary>
  ///    Namespace class for working with handles.
  ///  </summary>
  THandles = class
  private
    ///  <summary>
    ///    Returns the index of a handle within the handles list.
    ///  </summary>
    class function FindHandle( Handle: THandle; var HandleIndex: uint32 ): boolean;

  public
    ///  <summary>
    ///    Create a new handle to a darkglass object. (TInterfacedObject)
    ///    Pass in the handle kind, to indicate which kind of handle is to be
    ///    created, and also pass in an instance of the object to which the
    ///    handle refers.
    ///    The FreeMethod parameter is a callback to a method which is able
    ///    to free any objects associated with the handle.
    ///  </summary>
    class function CreateHandle( aKind: THandleKind; anInstance: IInterface; FreeMethod: THandleFreeMethod ): THandle; static;


    ///  <summary>
    ///    Verifies that the handle is of the correct kind.
    ///  </summary>
    class function VerifyHandle( Handle: THandle; HandleKind: THandleKind ): boolean; static;

    ///  <summary>
    ///    Returns the object instance for the object behind the handle.
    ///  </summary>
    class function InstanceOf( Handle: THandle ): IInterface;

    ///  <summary>
    ///    Frees the handle and the associated object.
    ///  </summary>
    class procedure FreeHandle( Handle: THandle ); static;
  end;

implementation
uses
  darkCollections.list;

type
  IHandleRecord = interface
    ['{8FD6CE52-3105-433D-B376-2B4D3D53F424}']
    function getHandleKind: THandleKind;
    function getInstance: IInterface;
    //- Pascal Only, Properties -//
    property Kind: THandleKind read getHandleKind;
    property Instance: IInterface read getInstance;
  end;

  THandleRecord = class( TInterfacedObject, IHandleRecord )
  private
    fFreeMethod: THandleFreeMethod;
    fKind: THandleKind;
    fInstance: IInterface;
  private //- IHandleRecord -//
    function getHandleKind: THandleKind;
    function getInstance: IInterface;
  public
    constructor Create( aKind: THandleKind; anInstance: IInterface; FreeMethod: THandleFreeMethod ); reintroduce;
    destructor Destroy; override;
  end;

var
  Handles: IList<IHandleRecord> = nil;

{ THandles }

class function THandles.CreateHandle( aKind: THandleKind; anInstance: IInterface; FreeMethod: THandleFreeMethod ): THandle;
var
  HandleRecord: IHandleRecord;
begin
  if not assigned(Handles) then begin
    Handles := TList<IHandleRecord>.Create(64,False,True);
  end;
  HandleRecord := THandleRecord.Create( aKind, anInstance, FreeMethod );
  Result := THandle(HandleRecord);
  Handles.Add(HandleRecord);
end;

class function THandles.FindHandle( Handle: THandle; var HandleIndex: uint32 ): boolean;
var
  idx: uint32;
begin
  Result := False;
  for idx := 0 to pred(Handles.Count) do begin
    if THandle(Handles[idx]) = Handle then begin
      HandleIndex := idx;
      Result := True;
      exit;
    end;
  end;
end;

class procedure THandles.FreeHandle(Handle: THandle);
var
  HandleIndex: uint32;
begin
  if not assigned(Handles) then begin
    exit;
  end;
  if FindHandle( Handle, HandleIndex ) then begin
    Handles.RemoveItem(HandleIndex);
  end;
end;

class function THandles.InstanceOf(Handle: THandle): IInterface;
var
  HandleRecord: IHandleRecord;
begin
  Result := nil;
  if not assigned(Handle) then begin
    exit;
  end;
  HandleRecord := IHandleRecord(Handle);
  Result := HandleRecord.Instance;
end;

class function THandles.VerifyHandle(Handle: THandle; HandleKind: THandleKind): boolean;
var
  HandleIndex: uint32;
begin
  Result := False;
  if not assigned(Handles) then begin
    exit;
  end;
  if FindHandle( Handle, HandleIndex ) then begin
    if (Handles[HandleIndex].Kind = HandleKind) and (assigned(Handles[HandleIndex].Instance)) then begin
      Result := True;
    end;
  end;
end;

{ THandleRecord }

constructor THandleRecord.Create( aKind: THandleKind; anInstance: IInterface; FreeMethod: THandleFreeMethod );
begin
  inherited Create;
  fFreeMethod := FreeMethod;
  fKind := aKind;
  fInstance := anInstance;
end;

destructor THandleRecord.Destroy;
begin
  if assigned(fFreeMethod) then begin
    fFreeMethod(fInstance);
  end;
  fInstance := nil;
  inherited Destroy;
end;

function THandleRecord.getHandleKind: THandleKind;
begin
  Result := fKind;
end;

function THandleRecord.getInstance: IInterface;
begin
  Result := fInstance;
end;

procedure ClearHandles;
begin
  if not assigned(Handles) then begin
    exit;
  end;
  Handles.Clear;
  Handles := nil;
end;

initialization
finalization
  ClearHandles;
  Handles := nil;

end.
