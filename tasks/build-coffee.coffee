require 'fluentnode'
gulp    = require 'gulp'
coffee  = require 'gulp-coffee'
debug   = require 'gulp-debug'
plumber = require 'gulp-plumber'
changed = require 'gulp-changed'

base_Source_Folder = '../../'
base_Target_Folder = '../../.dist'

coffee_Folders = ['./code/TM_Website/src'
                  './code/TM_Website/test'
                  './code/TM_GraphDB/src'
                  './code/TM_GraphDB/test'
                  './qa/TM_QA/test']

convert_Coffee = (source_Folder, target_Folder)->
  gulp.src source_Folder
      .pipe plumber()
      .pipe changed target_Folder, {extension: '.js'}
      #.pipe debug({title: "[#{target_Folder}]"})
      .pipe coffee()
      .pipe gulp.dest target_Folder



gulp.task 'coffee', ()->
  for coffee_Folder in coffee_Folders
    source_Folder = base_Source_Folder.path_Combine(coffee_Folder).path_Combine('./**/*.coffee')
    target_Folder = base_Target_Folder.path_Combine coffee_Folder
    convert_Coffee source_Folder, target_Folder

gulp.task 'coffee-watch', ()->
  for coffee_Folder in coffee_Folders
    source_Folder = base_Source_Folder.path_Combine(coffee_Folder).path_Combine('./**/*.coffee')
    gulp.watch source_Folder, ['coffee']
