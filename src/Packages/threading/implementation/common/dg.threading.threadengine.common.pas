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
unit dg.threading.threadengine.common;

interface
uses
  System.Generics.Collections,
  dg.threading.messagebus,
  dg.threading.enginethread,
  dg.threading.threadengine;

type
  TCommonThreadEngine = class( TInterfacedObject, IThreadEngine )
  private
    fThreads: TList<IEngineThread>;
  private //- IThreadEngine -//
    function getThreadCount: uint32;
    function getThread( idx: uint32 ): IEngineThread;
    procedure Run;
  public
    // If thread count is zero, or the parameter omitted, the thread engine
    // will determine the optimal number of threads to start.
    constructor Create(ThreadCount: uint32 = 0 ); reintroduce;
    destructor Destroy; override;
  end;

implementation
uses
  dg.threading.enginethread.common,
  dg.threading.enginethread.ui.common,
  dg.threading.messagebus.common;

{ TThreadEngine }

constructor TCommonThreadEngine.Create(ThreadCount: uint32);
var
  AThread: IEngineThread;
  NoThreads: uint32;
  idx: uint32;
begin
  inherited Create;
  fThreads := TList<IEngineThread>.Create;
  //- Create and add the UI thread.
  aThread := dg.threading.enginethread.ui.common.TCommonEngineThread.Create;
  fThreads.Add(AThread);
  //- Create ancillary threads
  if ThreadCount=0 then begin
    NoThreads := pred(System.CPUCount * 2);
  end else begin
    NoThreads := pred(ThreadCount);
  end;
  if NoThreads=0 then begin
    exit;
  end;
  for idx := 0 to pred(NoThreads) do begin
    aThread := dg.threading.enginethread.common.TCommonEngineThread.Create;
    fThreads.Add(AThread);
  end;
end;

destructor TCommonThreadEngine.Destroy;
begin
  fThreads.Clear;
  fThreads.DisposeOf;
  inherited Destroy;
end;

function TCommonThreadEngine.getThread(idx: uint32): IEngineThread;
begin
  Result := fThreads[idx];
end;

function TCommonThreadEngine.getThreadCount: uint32;
begin
  Result := fThreads.Count;
end;

procedure TCommonThreadEngine.Run;
var
  idx: uint32;
begin
  //- Start ancillary threads.
  if fThreads.Count>1 then begin
    for idx := 1 to pred(fThreads.Count) do begin
      fThreads[idx].Start;
    end;
  end;
  //- Start main thread
  fThreads[0].Start;
end;

end.
