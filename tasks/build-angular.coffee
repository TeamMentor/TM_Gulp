require 'fluentnode'
gulp        = require 'gulp'
concat      = require 'gulp-concat'
debug       = require 'gulp-debug'
runSequence = require 'run-sequence'

base_Source_Folder = '../../'
angular_Project    = base_Source_Folder.path_Combine 'code/TM_Angular'
target_Folder      = base_Source_Folder.path_Combine '.dist/code/TM_Angular/public'

log angular_Project.folder_Exists()

gulp.task 'combine-js', ->
  source_Files = [
    angular_Project.path_Combine 'bower_components/angular/angular.js'
    angular_Project.path_Combine 'bower_components/coffee-script/extras/coffee-script.js'
    angular_Project.path_Combine 'bower_components/coffee-script/jade.js'
  ]
  target_File = 'lib.js'

  log source_Files
  gulp.src source_Files
      .pipe debug({title: "[combine-angular-js]"})
      .pipe concat target_File
      .pipe gulp.dest target_Folder

  console.log 'combining Javascripts'


gulp.task 'angular', ->
  console.log 'angular task is here'
  runSequence [ 'combine-js']