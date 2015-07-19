changed = require 'gulp-changed'
debug    = require 'gulp-debug'
gulp     = require 'gulp'
mocha    = require 'gulp-mocha'
plumber  = require 'gulp-plumber'

tests_Folder = '../../.dist/qa/TM_QA/test/**/*.js'
code_Folders = [tests_Folder,
                '../../code/TM_Angular/src/**/*'
                '../../code/TM_Flare/**/*']

#process.env.NODE_PATH = '../../qa/TM_QA/node_modules'
  # this (above) is not working
  #   at the moment to run from .dist we need to use
  #   NODE_PATH=../../qa/TM_QA/node_modules gulp mocha-watch


gulp.task 'mocha', () ->
  console.log '....'
  gulp.src tests_Folder
      .pipe plumber()
      #.pipe debug({title: "[mocha]"})
      .pipe mocha { reporter: 'spec'}
      .on "error", (err)->
        log "[Mocha Error] #{err.message}"
        @.emit('end')

gulp.task 'mocha-watch', [ 'mocha'], ()->
  for code_Folder in code_Folders
    gulp.watch code_Folders, ['coffee', 'mocha']