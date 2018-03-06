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
unit dg.threading.enginethread.ui.common;

interface
uses
  system.generics.collections,
  dg.threading.messagebus,
  dg.threading.subsystem,
  dg.threading.enginethread;

type
  TCommonEngineThread = class( TInterfacedObject, IEngineThread )
  private
    fStarted: boolean;
    fSubSystems: TList<ISubSystem>;
  private //- IEngineThread -//
    procedure InstallSubsystem( aSubSystem: ISubSystem );
    procedure Start;
  private
    function Execute: boolean;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation
uses
  SysUtils;

{ TEngineThread }

procedure TCommonEngineThread.InstallSubsystem(aSubSystem: ISubSystem);
begin
  if fStarted then begin
    exit;
  end;
  fSubSystems.Add(aSubSystem);
  aSubsystem.Install;
end;

constructor TCommonEngineThread.Create;
begin
  inherited Create;
  fStarted := False;
  fSubSystems := TList<ISubSystem>.Create;
end;

destructor TCommonEngineThread.Destroy;
begin
  fSubSystems.DisposeOf;
  inherited Destroy;
end;

function TCommonEngineThread.Execute: boolean;
var
  idx: uint32;
begin
  Result := False;
  if fSubSystems.Count=0 then begin
    exit;
  end;
  for idx := 0 to pred(fSubsystems.Count) do begin
    if not fSubSystems[idx].Execute then begin
      fSubSystems[idx].Finalize;
      fSubSystems.Remove(fSubSystems[idx]);
    end;
  end;
  Result := True;
end;

procedure TCommonEngineThread.Start;
var
  idx: uint32;
begin
  if fSubSystems.Count>0 then begin
    for idx := 0 to pred(fSubsystems.Count) do begin
      fSubSystems[idx].Initialize;
    end;
  end;
  while Execute do Sleep(1);
end;


end.
