//------------------------------------------------------------------------------
// This file is a pascal translation of:
//    * android_native_app_glue.c
//    * android_native_app.glue.h
// from the android NDK.
//------------------------------------------------------------------------------
// The original source files are licensed under the Apache license v2.0
// which is copied below.
//------------------------------------------------------------------------------
// *
// * Copyright (C) 2010 The Android Open Source Project
// *
// * Licensed under the Apache License, Version 2.0 (the "License");
// * you may not use this file except in compliance with the License.
// * You may obtain a copy of the License at
// *
// *      http://www.apache.org/licenses/LICENSE-2.0
// *
// * Unless required by applicable law or agreed to in writing, software
// * distributed under the License is distributed on an "AS IS" BASIS,
// * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// * See the License for the specific language governing permissions and
// * limitations under the License.
// *
// */
//------------------------------------------------------------------------------
// This translation is part of the DarkGlass project, which is licensed under
// the MIT license. (copied below)
//------------------------------------------------------------------------------
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
unit dg.platform.appglue.android;

interface
uses
  Posix.SysTypes,
  AndroidAPI.Input,
  AndroidAPI.NativeActivity,
  AndroidAPI.Configuration,
  AndroidAPI.Looper,
  AndroidAPI.NativeWindow,
  AndroidAPI.Rect;

type
  TDelphiEntryPoint = procedure;

type
  Pandroid_app = ^TAndroid_app;

  Pandroid_poll_source = ^Tandroid_poll_source;
  Tandroid_poll_source = record
    id: int32;
    app: Pandroid_app;
    process: procedure( app: Pandroid_app; source: Pandroid_poll_source); cdecl;
  end;

  Tandroid_app = record
    userData: pointer;
    onAppCmd: procedure(app: Pandroid_app; cmd: int32); cdecl;
    onInputEvent: function(app: Pandroid_app; event: PAInputEvent ): int32; cdecl;
    activity: PANativeActivity;
    config: PAConfiguration;
    savedState: pointer;
    savedStateSize: nativeuint;
    looper: PALooper;
    inputQueue: PAInputQueue;
    window: PANativeWindow;
    contentRect: ARect;
    activityState: int32;
    destroyRequested: int32;
    mutex: pthread_mutex_t;
    cond: pthread_cond_t;
    msgread: int32;
    msgwrite: int32;
    thread: pthread_t;
    cmdPollSource: Tandroid_poll_source;
    inputPollSource: Tandroid_poll_source;
    running: int32;
    stateSaved: int32;
    destroyed: int32;
    redrawNeeded: int32;
    pendingInputQueue: PAInputQueue;
    pendingWindow: PANativeWindow;
    pendingContentRect: AREct;
  end;

const
   LOOPER_ID_MAIN = 1;
  LOOPER_ID_INPUT = 2;
   LOOPER_ID_USER = 3;

const
         APP_CMD_INPUT_CHANGED = 0;
           APP_CMD_INIT_WINDOW = 1;
           APP_CMD_TERM_WINDOW = 2;
        APP_CMD_WINDOW_RESIZED = 3;
  APP_CMD_WINDOW_REDRAW_NEEDED = 4;
  APP_CMD_CONTENT_RECT_CHANGED = 5;
          APP_CMD_GAINED_FOCUS = 6;
            APP_CMD_LOST_FOCUS = 7;
        APP_CMD_CONFIG_CHANGED = 8;
            APP_CMD_LOW_MEMORY = 9;
                 APP_CMD_START = 10;
                APP_CMD_RESUME = 11;
            APP_CMD_SAVE_STATE = 12;
                 APP_CMD_PAUSE = 13;
                  APP_CMD_STOP = 14;
               APP_CMD_DESTROY = 15;



function android_app_read_cmd(android_app: Pandroid_app): ShortInt; cdecl;
procedure android_app_pre_exec_cmd(android_app: Pandroid_app; cmd: ShortInt); cdecl;
procedure android_app_post_exec_cmd(android_app: Pandroid_app; cmd: ShortInt); cdecl;
procedure app_dummy();

implementation
uses
  Posix.Pthread,
  Posix.Unistd,
  Posix.StdLib,
  Posix.Dlfcn;

procedure app_dummy();
begin
end;

procedure free_saved_state(android_app: Pandroid_app); cdecl;
begin
  pthread_mutex_lock(android_app^.mutex);
  if android_app^.savedState <> nil then begin
    free(android_app^.savedState);
    android_app^.savedState := nil;
    android_app^.savedStateSize := 0;
  end;
  pthread_mutex_unlock(android_app^.mutex);
end;

function android_app_read_cmd( android_app: Pandroid_app ): int8; cdecl;
var
  cmd: int8;
begin
  Result := -1;
  if __read(android_app^.msgread, @cmd, sizeof(int8))=sizeof(int8) then begin
    case cmd of
      APP_CMD_SAVE_STATE: begin
        free_saved_state(android_app);
      end;
    end;
    result := cmd;
  end;
end;

procedure android_app_pre_exec_cmd(android_app: Pandroid_app; cmd: int8); cdecl;
begin
  case cmd of

    APP_CMD_INPUT_CHANGED: begin
      pthread_mutex_lock(android_app^.mutex);
      if assigned(android_app^.inputQueue) then begin
        AInputQueue_detachLooper(android_app^.inputQueue);
      end;
      android_app^.inputQueue := android_app^.pendingInputQueue;
      if assigned(android_app^.inputQueue) then begin
        AInputQueue_attachLooper(android_app^.inputQueue, android_app^.looper, LOOPER_ID_INPUT, nil, @android_app^.inputPollSource);
      end;
      pthread_cond_broadcast(android_app^.cond);
      pthread_mutex_unlock(android_app^.mutex);
    end;

    APP_CMD_INIT_WINDOW: begin
      pthread_mutex_lock(android_app^.mutex);
      android_app^.window := android_app^.pendingWindow;
      pthread_cond_broadcast(android_app^.cond);
      pthread_mutex_unlock(android_app^.mutex);
    end;

    APP_CMD_TERM_WINDOW: begin
      pthread_mutex_lock(android_app^.mutex);
      android_app^.window := nil;
      pthread_cond_broadcast(android_app^.cond);
      pthread_mutex_unlock(android_app^.mutex);
    end;

    APP_CMD_RESUME,
    APP_CMD_START,
    APP_CMD_PAUSE,
    APP_CMD_STOP: begin
      pthread_mutex_lock(android_app^.mutex);
      android_app^.activityState := cmd;
      pthread_cond_broadcast(android_app^.cond);
      pthread_mutex_unlock(android_app^.mutex);
    end;

    APP_CMD_CONFIG_CHANGED: begin
      AConfiguration_fromAssetManager(android_app^.config, android_app^.activity^.assetManager);
    end;

    APP_CMD_DESTROY: begin
      android_app^.destroyRequested := 1;
    end;

  end;
end;

procedure android_app_post_exec_cmd( android_app: Pandroid_app; cmd: int8 ); cdecl;
begin
  case cmd of
    APP_CMD_TERM_WINDOW: begin
      pthread_mutex_lock(android_app^.mutex);
      android_app^.window := nil;
      pthread_cond_broadcast(android_app^.cond);
      pthread_mutex_unlock(android_app^.mutex);
    end;
    APP_CMD_SAVE_STATE: begin
      pthread_mutex_lock(android_app^.mutex);
      android_app^.stateSaved := 1;
      pthread_cond_broadcast(android_app^.cond);
      pthread_mutex_unlock(android_app^.mutex);
    end;
    APP_CMD_RESUME: begin
      free_saved_state(android_app);
    end;
  end;
end;

procedure android_app_destroy( android_app: Pandroid_app ); cdecl;
begin
  free_saved_state(android_app);
  pthread_mutex_lock(android_app^.mutex);
  if assigned(android_app^.inputQueue) then begin
    AInputQueue_detachLooper(android_app^.inputQueue);
  end;
  AConfiguration_delete(android_app^.config);
  android_app^.destroyed := 1;
  pthread_cond_broadcast(android_app^.cond);
  pthread_mutex_unlock(android_app^.mutex);
end;

procedure process_input( app: Pandroid_app; source: Pandroid_poll_source ); cdecl;
var
  event: PAInputEvent;
  handled: int32;
begin
  event := nil;
  handled := 0;
  if AInputQueue_getEvent(app^.inputQueue, @event)>=0 then begin
    if AInputQueue_preDispatchEvent(app^.inputQueue, event)<>0 then begin
      exit;
    end;
    if assigned(app^.onInputEvent) then begin
      handled := app^.onInputEvent(app, event);
    end;
    AInputQueue_finishEvent(app^.inputQueue, event, handled);
  end;
end;

procedure process_cmd( app: Pandroid_app; source: Pandroid_poll_source ); cdecl;
var
  cmd: int8;
begin
  cmd := android_app_read_cmd(app);
  android_app_pre_exec_cmd(app, cmd);
  if assigned(app^.onAppCmd) then begin
    app^.onAppCmd( app, cmd );
  end;
  android_app_post_exec_cmd(app,cmd);
end;

procedure CallDelphiEntryPoint;
var
  ptrEntryPoint: pointer;
  EntryPoint: TDelphiEntryPoint;
  handle: nativeuint;
begin
  handle := dlopen(nil, RTLD_LAZY);
  if handle<>0 then begin
    ptrEntryPoint := dlSym(handle,'_NativeMain');
    dlclose(handle);
    if assigned(ptrEntryPoint) then begin
      Entrypoint := TDelphiEntryPoint(ptrEntryPoint);
      EntryPoint;
    end;
  end;
end;

procedure android_app_entry(param: pointer); cdecl;
var
  android_app: Pandroid_app;
  looper: PALooper;
begin
  android_app := Pandroid_app(param);
  android_app^.config := AConfiguration_new();
  AConfiguration_fromAssetManager(android_app^.config, android_app^.activity^.assetManager);
  android_app^.cmdPollSource.id := LOOPER_ID_MAIN;
  android_app^.cmdPollSource.app := android_app;
  android_app^.cmdPollSource.process := process_cmd;
  android_app^.inputPollSource.id := LOOPER_ID_INPUT;
  android_app^.inputPollSource.app := android_app;
  android_app^.inputPollSource.process := process_input;
  looper := ALooper_prepare(ALOOPER_PREPARE_ALLOW_NON_CALLBACKS);
  ALooper_addFd(looper, android_app^.msgread, LOOPER_ID_MAIN, ALOOPER_EVENT_INPUT, nil, @android_app^.cmdPollSource);
  android_app^.looper := looper;
  pthread_mutex_lock(android_app^.mutex);
  android_app^.running := 1;
  pthread_cond_broadcast(android_app^.cond);
  pthread_mutex_unlock(android_app^.mutex);
  //- Call main delphi entry point
  CallDelphiEntryPoint;
  android_app_destroy(android_app);
end;

//static struct android_app* android_app_create(ANativeActivity* activity, void* savedState, size_t savedStateSize) {
function android_app_create( activity: PANativeActivity; savedState: pointer; savedStateSize: nativeuint ): Pandroid_app; cdecl;
var
  android_app: Pandroid_app;
  msgpipe: array[0..1] of int32;
  attr: pthread_attr_t;
begin
  android_app := Pandroid_app(__malloc(sizeof(Tandroid_app)));
  FillChar(android_app^,sizeof(Tandroid_app),0);
  android_app^.activity := activity;
  pthread_mutex_init(android_app^.mutex, nil);
  pthread_cond_init(android_app^.cond, nil);
  if assigned(savedState) then begin
    android_app^.savedState := __malloc(savedStateSize);
    android_app^.savedStateSize := savedStateSize;
    Move(savedState,android_app^.savedState,savedStateSize);
  end;
  pipe(@msgpipe[0]);
  android_app^.msgread := msgpipe[0];
  android_app^.msgwrite := msgpipe[1];
  pthread_attr_init(attr);
  pthread_attr_setdetachstate(attr, PTHREAD_CREATE_DETACHED);
  pthread_create(android_app^.thread, attr, @android_app_entry, android_app);
  pthread_mutex_lock(android_app^.mutex);
  while not (android_app^.running=0) do begin
    pthread_cond_wait(android_app^.cond, android_app^.mutex);
  end;
  pthread_mutex_unlock(android_app^.mutex);
  result := android_app;
end;

procedure android_app_write_cmd(android_app: Pandroid_app; cmd: int8); cdecl;
begin
  if ( __write(android_app^.msgwrite, @cmd, sizeof(int8)) <> sizeof(int8)) then begin
    //- Failure writing android_app cmd!
    exit;
  end;
end;

procedure android_app_set_input( android_app: Pandroid_app; inputQueue: PAInputQueue ); cdecl;
begin
  pthread_mutex_lock(android_app^.mutex);
  android_app^.pendingInputQueue := inputQueue;
  android_app_write_cmd(android_app, APP_CMD_INPUT_CHANGED);
  while (android_app^.inputQueue <> android_app^.pendingInputQueue) do begin
    pthread_cond_wait(android_app^.cond, android_app^.mutex);
  end;
  pthread_mutex_unlock(&android_app^.mutex);
end;

procedure android_app_set_window( android_app: Pandroid_app; window: PANativeWindow ); cdecl;
begin
  pthread_mutex_lock(&android_app^.mutex);
  if assigned(android_app^.pendingWindow) then begin
    android_app_write_cmd(android_app, APP_CMD_TERM_WINDOW);
  end;
  android_app^.pendingWindow := window;
  if assigned(window) then begin
    android_app_write_cmd(android_app, APP_CMD_INIT_WINDOW);
  end;
  while (android_app^.window <> android_app^.pendingWindow) do begin
    pthread_cond_wait(android_app^.cond, android_app^.mutex);
  end;
  pthread_mutex_unlock(android_app^.mutex);
end;

procedure android_app_set_activity_state( android_app: Pandroid_app; cmd: int8 ); cdecl;
begin
  pthread_mutex_lock(android_app^.mutex);
  android_app_write_cmd(android_app, cmd);
  while (android_app^.activityState<>cmd) do begin
    pthread_cond_wait(android_app^.cond, android_app^.mutex);
  end;
  pthread_mutex_unlock(android_app^.mutex);
end;

procedure android_app_free(android_app: Pandroid_app);  cdecl;
begin
  pthread_mutex_lock(android_app^.mutex);
  android_app_write_cmd(android_app, APP_CMD_DESTROY);
  while not (android_app^.destroyed=0) do begin
    pthread_cond_wait(android_app^.cond, android_app^.mutex);
  end;
  pthread_mutex_unlock(android_app^.mutex);
  __close(android_app^.msgread);
  __close(android_app^.msgwrite);
  pthread_cond_destroy(android_app^.cond);
  pthread_mutex_destroy(&android_app^.mutex);
  free(android_app);
end;

procedure onDestroy(activity: PANativeActivity); cdecl;
begin
  android_app_free(Pandroid_app(activity^.instance));
end;

procedure onStart(activity: PANativeActivity); cdecl;
begin
  android_app_set_activity_state(Pandroid_app(activity^.instance), APP_CMD_START);
end;

procedure onResume(activity: PANativeActivity); cdecl;
begin
  android_app_set_activity_state(Pandroid_app(activity^.instance), APP_CMD_RESUME);
end;

function onSaveInstanceState(activity: PANativeActivity; var outLen: nativeuint): pointer; cdecl;
var
  android_app: Pandroid_app;
  savedState: pointer;
begin
  savedState := nil;
  android_app := Pandroid_app(activity^.instance);
  pthread_mutex_lock(android_app^.mutex);
  android_app^.stateSaved := 0;
  android_app_write_cmd(android_app, APP_CMD_SAVE_STATE);
  while (android_app^.stateSaved=0) do begin
    pthread_cond_wait(android_app^.cond, android_app^.mutex);
  end;
  if (android_app^.savedState <> nil) then begin
    savedState := android_app^.savedState;
    outLen := nativeuint(android_app^.savedState);
    android_app^.savedState := nil;
    android_app^.savedStateSize := 0;
  end;
  pthread_mutex_unlock(android_app^.mutex);
  Result := savedState;
end;

procedure onPause( activity: PANativeActivity ); cdecl;
begin
  android_app_set_activity_state(Pandroid_app(activity^.instance), APP_CMD_PAUSE);
end;

procedure onStop( activity: PANativeActivity ); cdecl;
begin
  android_app_set_activity_state(Pandroid_app(activity^.instance), APP_CMD_STOP);
end;

procedure onConfigurationChanged( activity: PANativeActivity ); cdecl;
begin
  android_app_write_cmd(Pandroid_app(activity^.instance), APP_CMD_CONFIG_CHANGED);
end;

procedure onLowMemory( activity: PANativeActivity ); cdecl;
begin
  android_app_write_cmd(Pandroid_app(activity^.instance), APP_CMD_LOW_MEMORY);
end;

procedure onWindowFocusChanged( activity: PANativeActivity; focused: int32 ); cdecl;
begin
  if focused=0 then begin
    android_app_write_cmd(Pandroid_app(activity^.instance),APP_CMD_LOST_FOCUS);
  end else begin
    android_app_write_cmd(Pandroid_app(activity^.instance),APP_CMD_GAINED_FOCUS);
  end;
end;

procedure onNativeWindowCreated( activity: PANativeActivity; window: PANativeWindow ); cdecl;
begin
  android_app_set_window(Pandroid_app(activity^.instance), window);
end;

procedure onNativeWindowDestroyed( activity: PANativeActivity; window: PANativeWindow ); cdecl;
begin
  android_app_set_window(Pandroid_app(activity^.instance), nil);
end;

procedure onInputQueueCreated(activity: PANativeActivity; queue: PAInputQueue ); cdecl;
begin
  android_app_set_input(Pandroid_app(activity^.instance), queue);
end;

procedure onInputQueueDestroyed(activity: PANativeActivity; queue: PAInputQueue ); cdecl;
begin
  android_app_set_input(Pandroid_app(activity^.instance), nil);
end;

procedure ANativeActivity_onCreate(activity: PANativeActivity; savedState: pointer; savedStateSize: nativeuint); cdecl;
var
  t: boolean;
begin
  t := true;
  while t do;
  if assigned(System.DelphiActivity) then begin
    exit;
  end;
  System.DelphiActivity := activity;
  System.JavaMachine := activity^.vm;
  System.JavaContext := activity^.clazz;
  activity^.callbacks^.onDestroy := onDestroy;
  activity^.callbacks^.onStart := onStart;
  activity^.callbacks^.onResume := onResume;
  activity^.callbacks^.onSaveInstanceState := TOnSaveInstanceStateCallback(@onSaveInstanceState);
  activity^.callbacks^.onPause := onPause;
  activity^.callbacks^.onStop := onStop;
  activity^.callbacks^.onConfigurationChanged := onConfigurationChanged;
  activity^.callbacks^.onLowMemory := onLowMemory;
  activity^.callbacks^.onWindowFocusChanged := onWindowFocusChanged;
  activity^.callbacks^.onNativeWindowCreated := onNativeWindowCreated;
  activity^.callbacks^.onNativeWindowDestroyed := onNativeWindowDestroyed;
  activity^.callbacks^.onInputQueueCreated := onInputQueueCreated;
  activity^.callbacks^.onInputQueueDestroyed := onInputQueueDestroyed;
  activity^.instance := android_app_create(activity, savedState, savedStateSize);
end;exports  ANativeActivity_onCreate;
end.
