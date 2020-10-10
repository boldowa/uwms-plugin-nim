# Package

version       = "0.1.0"
author        = "boldowa"
description   = "uwms plugin"
license       = "MIT"
srcDir        = "src"
binDir        = "bin"
installExt    = @["nim"]

#bin           = @["plg_uwms_plugin"]
#when defined windos:
#  namedBin      = @["plg_uwms_plugin.dll"]
#elif defined macosx:
#  bin           = @["plg_uwms_plugin.dynlib"]
#else:
#  namedBin["plg_uwms_plugin"] = "plg_uwms_plugin.so"



# Dependencies

requires "nim >= 1.2.6"
