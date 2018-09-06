child_process = require 'child_process'
process       = require 'process'
fs            = require 'fs'
path          = require 'path'

npm           = require 'npm'

projectRoot   = __dirname
genDir        = path.resolve projectRoot, 'generated'

{chdir}       = process

exec  = (cmd)  -> new Promise (resolve) -> child_process.exec cmd, resolve
mkdir = (path) -> new Promise (resolve) -> fs.mkdir path, resolve

task 'clean', 'Purge generated files', (options) ->
  await exec "rm -rf #{genDir}"

task 'install', 'Install required packages', (options) ->
  await exec 'npm install'

task 'gen', 'Generate site content from templates', (options) ->
  invoke 'install'
  invoke 'clean'

  chdir projectRoot
  await mkdir genDir

task 'pub', 'Publish generated content', (options) ->
  task 'gen'

  # TODO: figure out publishing
