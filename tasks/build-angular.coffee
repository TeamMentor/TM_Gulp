require 'fluentnode'
gulp        = require 'gulp'
changed     = require 'gulp-changed'
coffee      = require 'gulp-coffee'
jade        = require 'gulp-jade'
concat      = require 'gulp-concat'
debug       = require 'gulp-debug'
uglify      = require 'gulp-uglify'
plumber     = require 'gulp-plumber'
runSequence = require 'run-sequence'



base_Source_Folder    = '../../'
angular_Project       = base_Source_Folder.path_Combine 'code/TM_Angular'
target_Folder         = base_Source_Folder.path_Combine 'code/TM_Angular/build'
jade_Files            = base_Source_Folder.path_Combine 'code/TM_Flare/component/**/*.jade'
jade_Flare_Files      = base_Source_Folder.path_Combine 'code/TM_Flare/**/*.jade'
jade_Component_Folder = base_Source_Folder.path_Combine 'code/TM_Flare/views'
coffee_Files          = base_Source_Folder.path_Combine 'code/TM_Angular/src/**/*.coffee'

concat_Code_File        = 'js/code.js'
concat_Components_File  = 'js/components.js'
concat_Css_File         = 'css/lib.css'
concat_Lib_File         = 'js/lib.js'


gulp.task 'combine-js', ->
  source_Files = [
    angular_Project.path_Combine 'bower_components/angular/angular.js'
    angular_Project.path_Combine 'bower_components/angular-foundation-bower/mm-foundation-tpls.min.js'
    angular_Project.path_Combine 'bower_components/jade/runtime.js'
    angular_Project.path_Combine 'bower_components/angular-slider/slider.js'
    angular_Project.path_Combine 'bower_components/angular-ui-router/release/angular-ui-router.min.js'
    angular_Project.path_Combine 'bower_components/chai/chai.js'
  ]


  gulp.src source_Files
      #.pipe debug({title: "[combine-angular-js]"})
      .pipe concat concat_Lib_File
      #.pipe uglify()                               # this takes a good number of secs to go from 1M to 300k so it might be better to use the minified versions directly
      .pipe gulp.dest target_Folder

gulp.task 'combine-css', ->
  source_Files = [
    #angular_Project.path_Combine 'bower_components/angular-ui-select/dist/select.css'
    angular_Project.path_Combine 'bower_components/angular-slider/slider.css'
  ]
  gulp.src source_Files
      .pipe concat concat_Css_File
      .pipe gulp.dest target_Folder

gulp.task 'compile-coffee', ->
  gulp.src [coffee_Files]
      #.pipe debug({title: "[coffee]"})
      .pipe plumber()
      .pipe coffee()
      .pipe concat concat_Code_File
      .pipe gulp.dest target_Folder

gulp.task 'compile-coffee-js', ->
  gulp.src [coffee_Files]
  #.pipe debug({title: "[coffee]"})
      .pipe plumber()
      .pipe coffee()
      .pipe gulp.dest target_Folder.append('-js')

gulp.task 'angular', ->
  runSequence [ 'combine-js', 'combine-css' , 'compile-coffee', 'compile-coffee-js']

gulp.task 'angular-watch', ['angular'], ()->
#  gulp.watch jade_Files       , ['compile-jade']
#  gulp.watch jade_Flare_Files , ['compile-jade']
  gulp.watch coffee_Files     , ['compile-coffee',  'compile-coffee-js']

