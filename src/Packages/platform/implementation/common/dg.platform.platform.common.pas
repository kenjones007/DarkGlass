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
unit dg.platform.platform.common;

interface
uses
  system.generics.collections,
  dg.threading,
  dg.platform.platform;

type
  TCommonPlatform = class( TInterfacedObject, IPlatform )
  protected
    fThreadEngine: IThreadEngine;
  protected //- IPlatform -//
    function GetChannelConnection( ChannelName: string ): THChannelConnection;
    function SendMessage( ConnectionHandle: THChannelConnection; MessageValue: uint32; ParamA: NativeUInt; ParamB: NativeUInt; WaitFor: Boolean = False  ): TMessageResponse;
    function Initialize: boolean; virtual; abstract;
    function Finalize: boolean; virtual;  abstract;
    procedure Run;  virtual;
  public
    constructor Create; reintroduce; virtual;
    destructor Destroy; override;
  end;

implementation
uses
  dg.threading.threadengine.standard;

{ TCustomPlatform }

constructor TCommonPlatform.Create;
begin
  inherited Create;
  fThreadEngine := TThreadEngine.Create;
end;

destructor TCommonPlatform.Destroy;
begin
  fThreadEngine := nil;
  inherited Destroy;
end;

function TCommonPlatform.GetChannelConnection(ChannelName: string): THChannelConnection;
begin
  Result := MessageBus.GetConnection(ChannelName);
end;

procedure TCommonPlatform.Run;
begin
  fThreadEngine.Run;
end;

function TCommonPlatform.SendMessage( ConnectionHandle: THChannelConnection; MessageValue: uint32; ParamA: NativeUInt; ParamB: NativeUInt; WaitFor: Boolean = False ): TMessageResponse;
begin
  Result := MessageBus.SendMessage(ConnectionHandle, MessageValue, ParamA, ParamB, WaitFor );
end;

end.
