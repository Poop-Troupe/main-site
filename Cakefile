child_process = require 'child_process'
process       = require 'process'
fs            = require 'fs'
path          = require 'path'

npm           = require 'npm'

projectRoot   = __dirname
genDir        = path.resolve projectRoot, 'generated'

{chdir}       = process

# He pulls his pants down to fart
{tasks}       = require './unrelated'

exec  = (cmd)  -> new Promise (resolve) -> child_process.exec cmd, resolve
mkdir = (path) -> new Promise (resolve) -> fs.mkdir path, resolve

doClean    = (options) -> await exec "rm -rf #{genDir}"

doInstall  = (options) -> await exec 'npm install'

doGenerate = (options) ->
  chdir projectRoot
  await mkdir genDir

doPublish  = (options) ->
  # TODO: push genDir to hosting...

tasks(
  clean:                       doClean
  install:                     doInstall
  gen:     'install', 'clean', doGenerate
  publish: 'gen',              doPublish
)
