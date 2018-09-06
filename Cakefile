child_process = require 'child_process'
process       = require 'process'
fs            = require 'fs'
path          = require 'path'

pug           = require 'pug'

projectRoot   = __dirname
genDir        = path.resolve projectRoot, 'generated'

{chdir}       = process

exec  = (cmd)  -> new Promise (resolve) -> child_process.exec cmd, resolve
mkdir = (path) -> new Promise (resolve) -> fs.mkdir path, resolve

wrapTask = (fn) ->
  (options) ->
    Promise.resolve()
      .then        -> fn options
      .then        -> console.log 'done.'
      .catch (err) -> console.log "Oops:", err

doClean = (options) ->
  exec "rm -rf #{genDir}"

doInstall = (options) ->
    exec 'npm install'

doGenerate = (options) ->
  Promise.resolve()
    .then -> doInstall options
    .then -> doClean   options
    .then -> chdir     projectRoot
    .then -> mkdir     genDir
    .then ->
      new Promise (resolve) ->
        pug.renderFile indexPath, options, resolve

doPublish = (options) ->
  Promise.resolve()
    .then -> doGenerate options
    .then -> # TODO: figure out publishing

task 'clean',   'Purge generated files',        wrapTask doClean
task 'install', 'Install required packages',    wrapTask doInstall
task 'gen',     'Generate site from templates', wrapTask doGenerate
task 'pub',     'Publish generated content',    wrapTask doPublish
