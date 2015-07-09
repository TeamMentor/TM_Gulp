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
jade_Files            = base_Source_Folder.path_Combine 'code/TM_Angular/src/jade/**/*.jade'
jade_Component_Folder = base_Source_Folder.path_Combine 'code/TM_Jade/component'
coffee_Files          = base_Source_Folder.path_Combine 'code/TM_Angular/src/coffee/**/*.coffee'

concat_Code_File    = 'js/code.js'
concat_Css_File     = 'css/lib.css'
concat_Jade_Js_File = 'js/jade.js'
concat_Lib_File     = 'js/lib.js'


gulp.task 'combine-js', ->
  source_Files = [
    angular_Project.path_Combine 'bower_components/angular/angular.js'
    angular_Project.path_Combine 'bower_components/angular-foundation-bower/mm-foundation-tpls.min.js'
    angular_Project.path_Combine 'bower_components/jade/runtime.js'
    angular_Project.path_Combine 'bower_components/angular-slider/slider.js'
    angular_Project.path_Combine 'bower_components/angular-ui-router/release/angular-ui-router.min.js'
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

gulp.task 'compile-jade', ->
  target_Folder_Html = target_Folder.path_Combine 'html'
  gulp.src jade_Files
      .pipe plumber()
      .pipe changed(target_Folder_Html, {extension: '.html'})
      #.pipe debug({title: "[compile-jade]"})
      .pipe jade()
      .pipe gulp.dest target_Folder_Html

gulp.task 'compile-jade-components',->
  # this needs to be converted into a gulp plugin (or find one that works)

  jade_Compiler = require('gulp-jade/node_modules/jade');

  jade_Js = ""
  for file in jade_Component_Folder.files()
    file_name = file.file_Name_Without_Extension()
    options = {name : "jade_#{file_name}" }
    jsFunctionString = jade_Compiler.compileFileClient(file, options);
    jade_Js += jsFunctionString + '\n\n'

  target_File = target_Folder.path_Combine(concat_Jade_Js_File)
  jade_Js.save_As target_File

  #"component jade files saved as #{target_File}".log()

  return
  #options = { client: true }
  #gulp.src jade_Component_Files
  #    .pipe debug({title: "[coffee]"})
  #    #.pipe jade(options)
  #    .pipe concat concat_Jade_Js_File
  #    .pipe gulp.dest target_Folder


gulp.task 'compile-coffee', ->
  gulp.src coffee_Files
      #.pipe debug({title: "[coffee]"})
      .pipe plumber()
      .pipe coffee()
      .pipe concat concat_Code_File
      .pipe gulp.dest target_Folder

gulp.task 'angular', ->
  runSequence [ 'combine-js', 'combine-css', 'compile-jade-components' , 'compile-jade', 'compile-coffee']

gulp.task 'angular-watch', ['angular'], ()->
  gulp.watch jade_Files  , ['compile-jade']
  gulp.watch coffee_Files, ['compile-coffee']

