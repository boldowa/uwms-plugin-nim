## uwms plugin template
##

type DependsReturn* = object
  id* : cstring
  vermin* : cint
  vermax* : cint

type ControlInfo* = object
  dtype* : cstring
  data* : cstring

# プラグイン関数の型定義
type
    ProcUwmsGetPluginVersion*       = proc():cint {.gcsafe, stdcall.}
    ProcUwmsGetPluginVersionStr*    = proc():cstring {.gcsafe, stdcall.}
    ProcUwmsGetPluginId*            = proc():cstring {.gcsafe, stdcall.}
    ProcUwmsGetPluginName*          = proc():cstring {.gcsafe, stdcall.}
    ProcUwmsGetPluginGroupId*       = proc():cstring {.gcsafe, stdcall.}
    ProcUwmsGetPluginDepends*       = proc():ptr UncheckedArray[DependsReturn] {.gcsafe, stdcall.}
    ProcUwmsGetPluginControlInfo*   = proc():ptr ControlInfo {.gcsafe, stdcall.}
    ProcUwmsPluginInitialize*       = proc(p:pointer, v:cint):cint {.gcsafe, stdcall.}  # pointer = ptr[UwmsPlugin]
    ProcUwmsPluginExporter*         = proc() {.gcsafe, stdcall.}
    ProcUwmsPluginImporter*         = proc() {.gcsafe, stdcall.}
    ProcUwmsPluginRegister*         = proc() {.gcsafe, stdcall.}
    ProcUwmsPluginFinalize*         = proc() {.gcsafe, stdcall.}


#------------------------------------------------


proc uwmsGetPluginVersion*():cint {.dynlib, exportc, stdcall.} =
  return 1

proc uwmsGetPluginVersionStr*():cstring {.dynlib, exportc, stdcall.} =
  return "0.0.1"

proc uwmsGetPluginId*():cstring {.dynlib, exportc, stdcall.} =
  return "test-id"

proc uwmsGetPluginName*():cstring {.dynlib, exportc, stdcall.} =
  return "test-name"

proc uwmsGetPluginGroupId*():cstring {.dynlib, exportc, stdcall.} =
  return "test-gid"

proc uwmsGetPluginDepends*():ptr UncheckedArray[DependsReturn] {.dynlib, exportc, stdcall.} =
  let deps {.global.} : array[2, DependsReturn] = [
    DependsReturn(id: "test-dep", vermin: 1, vermax: 3),
    DependsReturn(id: nil, vermin: -1, vermax: -1)
  ]
  return cast[ptr UncheckedArray[DependsReturn]](deps.unsafeAddr)

proc uwmsGetPluginControlInfo*():ptr ControlInfo {.dynlib, exportc, stdcall.} =
  return nil

proc uwmsPluginInitialize*(p:pointer, v:cint):cint {.dynlib, exportc, stdcall.} =
  return 0

proc uwmsPluginExporter*() {.dynlib, exportc, stdcall.} =
  return

proc uwmsPluginImporter*() {.dynlib, exportc, stdcall.} =
  return

proc uwmsPluginRegister*() {.dynlib, exportc, stdcall.} =
  return

proc uwmsPluginFinalize*() {.dynlib, exportc, stdcall.} =
  return

#when isMainModule:
#  echo "uwms test plugin -- v0.0.1"
