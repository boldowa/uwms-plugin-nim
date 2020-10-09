# uwms-plugin-nim
uwms plugin test module


## How to build plugin

### Debug
`nim c plug_src/uwms_plugin_nim.nim`
### Release
`nim c -d:release --opt:speed plug_src/uwms_plugin_nim.nim`

## How to test
First, you need to build plugin.

Then, enter it.

`nimble test`


