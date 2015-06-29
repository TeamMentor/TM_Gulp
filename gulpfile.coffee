gulp        = require('gulp')
requireDir  = require( 'require-dir' )

requireDir  './tasks', { recurse: true }

gulp.task 'build', ()->

  runSequence 'clean'   ,
              [   'jade'
                  'sass'
                  'scripts'
                  'images'
                  'favicon'],
             'watch'
             'connect'

gulp.task 'default', ->

  console.log '... all good here...'