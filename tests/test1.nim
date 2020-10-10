
import dynlib
import unittest

import plg_uwms_plugin

when defined windows:
    const plugin_ext = ".dll"
elif defined macosx:
    const plugin_ext = ".dynlib"
else: # linux, unix
    const plugin_ext = ".so"

const libpath = "bin/plg_uwms_plugin" & plugin_ext

test "plugin load and unload check":
  var lib = loadlib(libpath)
  check lib != nil
  if lib != nil : unloadLib(lib)

test "plugin version functins check":
  var lib = loadlib(libpath)
  check lib != nil

  var getv =  cast[ProcUwmsGetPluginVersion](lib.symAddr("uwmsGetPluginVersion"))
  check getv != nil
  check getv() == 1

  var getvs = cast[ProcUwmsGetPluginVersionStr](lib.symAddr("uwmsGetPluginVersionStr"))
  check getvs != nil
  check getvs() == "0.0.1"

  if lib != nil : unloadLib(lib)


test "plugin string info function check":
  var lib = loadlib(libpath)
  check lib != nil

  var getid = cast[ProcUwmsGetPluginId](lib.symAddr("uwmsGetPluginId"))
  check getid != nil
  check getid() == "test-id"

  var getname = cast[ProcUwmsGetPluginName](lib.symAddr("uwmsGetPluginName"))
  check getname != nil
  check getname() == "test-name"

  var getgid = cast[ProcUwmsGetPluginGroupId](lib.symAddr("uwmsGetPluginGroupId"))
  check getgid != nil
  check getgid() == "test-gid"

  if lib != nil : unloadLib(lib)


test "plugin dep info function check":
  var lib = loadlib(libpath)
  check lib != nil

  var getdep = cast[ProcUwmsGetPluginDepends](lib.symAddr("uwmsGetPluginDepends"))
  check getdep != nil
  var v : ptr UncheckedArray[DependsReturn]
  v = getdep()
  var x = v[0]
  check x.id == "test-dep"
  check x.vermin == 1
  check x.vermax == 3
  x = v[1]
  check x.id == nil
  check x.vermin == -1
  check x.vermax == -1

  if lib != nil : unloadLib(lib)


test "plugin control info function check":
  var lib = loadlib(libpath)
  check lib != nil

  var getcon = cast[ProcUwmsGetPluginControlInfo](lib.symAddr("uwmsGetPluginControlInfo"))
  check getcon != nil
  check getcon() == nil

  if lib != nil : unloadLib(lib)


test "function executable check":
  var lib = loadlib(libpath)
  check lib != nil

  var pini = cast[ProcUwmsPluginInitialize](lib.symAddr("uwmsPluginInitialize"))
  check pini != nil
  var plg:pointer
  var ver:cint = 1
  check pini(plg, ver) == 0

  var pexp = cast[ProcUwmsPluginExporter](lib.symAddr("uwmsPluginExporter"))
  check pexp != nil
  pexp()

  var pimp = cast[ProcUwmsPluginImporter](lib.symAddr("uwmsPluginImporter"))
  check pimp != nil
  pimp()

  var preg = cast[ProcUwmsPluginRegister](lib.symAddr("uwmsPluginRegister"))
  check preg != nil
  preg()

  var pfin = cast[ProcUwmsPluginFinalize](lib.symAddr("uwmsPluginFinalize"))
  check pfin != nil
  pfin()

  if lib != nil : unloadLib(lib)
