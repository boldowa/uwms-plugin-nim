# uwms-plugin-nim
uwms plugin test module


## How to build plugin

### Debug
`nim c src/plg_uwms_plugin.nim`
### Release
`nim c -d:release --opt:speed src/plg_uwms_plugin.nim`

## How to test
First, you need to build plugin.

Then, enter it.

`nimble test`


