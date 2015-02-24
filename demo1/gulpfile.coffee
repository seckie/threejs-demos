gulp = require('gulp')
gutil = require('gulp-util')

coffee = require('gulp-coffee')
coffeelint = require('gulp-coffeelint')
concat = require('gulp-concat')
uglify = require('gulp-uglify')
jshint = require('gulp-jshint')
stylus = require('gulp-stylus')
nib = require('nib')
jade = require('gulp-jade')
jasmine = require('gulp-jasmine')
karma = require('karma').server
notify = require('gulp-notify')

browserify = require('browserify')
source = require('vinyl-source-stream')

browserSync = require('browser-sync')
fs = require('fs')

publicDir = './'

paths = {
  jade: [
    'src/jade/*.jade'
    'src/jade/!(include)/*.jade'
  ]
  html: [
    publicDir + '**/*.html'
  ]
  htmlDir: publicDir
  coffee: [
    'src/coffee/**/*.coffee'
  ]
  coffeeMain: './src/coffee/main.coffee'
  js: [
    publicDir + 'js/**/*.js'
  ]
  jsDir: publicDir + 'js'
  bundleName: 'bundle.js'
  coffeeSpec: [
    'src/spec/**/*.coffee'
  ]
  spec: [
    'spec/**/*.js'
  ]
  specDir: 'spec'
  stylus: [ 'src/stylus/**/*.styl' ]
  cssDir: publicDir + 'css'
  copySrc: [
    '../node_modules/three/three.js'
  ]
  copyDest: [
    publicDir + 'js'
  ]
  spriteImg: [
    'src/sprite/*'
  ]
  spriteImgName: [
    'main.png'
  ]
  spriteCSSName: [
    'sprite-main.styl'
  ]
  spriteImgDest: publicDir + 'img/sprite'
  spriteCSSDest: 'src/stylus/sprite'
}

errorHandler = (e) ->
  args = Array.prototype.slice.call(arguments)
  notify.onError(
    title: 'Compile Error'
    message: '<%= error %>'
    sound: false
  ).apply(@, args)
  @.emit('end')


###
  jade
###
jadeLocalVar = {
  build: false
}
gulp.task('jade-before-build', (cb) ->
  jadeLocalVar.build = true
  cb()
)
gulp.task('jade', () ->
  gulp.src(paths.jade)
    .pipe(jade(
        pretty: true
        locals: jadeLocalVar
      ).on('error', errorHandler))
    .pipe(gulp.dest(paths.htmlDir))
)


###
  Coffee Script
###

gulp.task('coffee', () ->
#   gulp.src(paths.coffee)
#     .pipe(coffee().on('error', errorHandler))
#     .pipe(coffeelint(
#         'no_trailing_whitespace':
#           'level': 'error'
#       ).on('error', errorHandler))
#     .pipe(gulp.dest(paths.jsDir))
#     .pipe(browserSync.reload({ stream: true }))
  browserify(
      entries: [ paths.coffeeMain ]
      extensions: [ '.coffee' ]
      debug: true
    )
    .transform('coffeeify')
    .bundle()
    .on('error', errorHandler)
    .pipe(source(paths.bundleName))
    .pipe(gulp.dest(paths.jsDir))
    .pipe(browserSync.reload({ stream: true }))
)
gulp.task('coffee-spec', () ->
  gulp.src(paths.coffeeSpec)
    .pipe(coffee(
        bare: true
      ).on('error', errorHandler))
    .pipe(coffeelint(
        'no_trailing_whitespace':
          'level': 'error'
      ).on('error', errorHandler))
    .pipe(gulp.dest(paths.specDir))
)


###
  jshint
###

gulp.task('jshint', () ->
  gulp.src(paths.js)
    .pipe(jshint().on('error', errorHandler))
    .pipe(jshint.reporter('default'))
)


###
  test
###
#
gulp.task('test', (cb) ->
  gulp.src(paths.spec)
    .pipe(jasmine())
  karma.start(
    configFile: __dirname + '/karma.conf.js'
    singleRun: true
  , cb)
)
gulp.task('tdd', (cb) ->
  karma.start(
    configFile: __dirname + '/karma.conf.js'
  , cb)
)


###
  stylus
###

gulp.task('stylus', () ->
  gulp.src(paths.stylus)
    .pipe(stylus(
      use: [ nib() ]
    ).on('error', errorHandler))
    .pipe(gulp.dest(paths.cssDir))
    .pipe(browserSync.reload({ stream: true }))
)


###
  sprite
###

gulp.task('sprite-base', (cb) ->
  path = (paths.spriteImgDest).replace(publicDir, '/')
  for src, i in paths.spriteImg
    stream = spritesmith(
      imgName: paths.spriteImgName[i]
      cssName: paths.spriteCSSName[i]
      imgPath: path + '/' + paths.spriteImgName[i]
      algorithm: 'binary-tree'
      engine: 'gmsmith'
      imgOpts: {exportOpts: {quality: 100}}
      padding: 2
    ).on('error', errorHandler)
    spriteData = gulp.src(src).pipe(stream)
    spriteData.img.pipe(gulp.dest(paths.spriteImgDest))
    spriteData.css.pipe(gulp.dest(paths.spriteCSSDest))
  cb()
)



###
  copy
###

gulp.task('copy', (cb) ->
  for src, i in paths.copySrc
    gulp.src(src)
      .pipe(gulp.dest(paths.copyDest[i]))
  cb()
)


###
  server
###
gulp.task('browser-sync', () ->
  browserSync(
    server:
      baseDir: './'
    startPath: '/'
  )
)
gulp.task('browser-sync-silent', () ->
  browserSync(
    server:
      baseDir: './'
    open: false
  )
)


###
  watch
###
gulp.task('watch', (cb) ->
  gutil.log('start watching')
  # coffee
  #gulp.watch(paths.coffee).on('change', (e) ->
  #  filename = e.path.replace(__dirname + '/src/coffee/', '')
  #  srcPath = e.path.replace(__dirname + '/', '')
  #  destPath = e.path.replace(__dirname + '/src/coffee', paths.jsDir).replace('/' + filename, '')
  #  gutil.log('Coffee file changed.')
  #  gulp.src(srcPath)
  #    .pipe(coffee().on('error', errorHandler))
  #    .pipe(gulp.dest(destPath))
  #    .pipe(browserSync.reload({ stream: true }))
  #)
  gulp.watch(paths.coffee, [ 'coffee' ])
  # coffee spec
  gulp.watch(paths.coffeeSpec).on('change', (e) ->
    filename = e.path.replace(__dirname + '/src/spec/', '')
    srcPath = e.path.replace(__dirname + '/', '')
    destPath = e.path.replace(__dirname + '/src/spec', paths.specDir).replace('/' + filename, '')
    gutil.log('Coffee-Spec file changed.')
    gulp.src(srcPath)
      .pipe(coffee(
          bare: true
        ).on('error', errorHandler))
      .pipe(gulp.dest(destPath))
      .pipe(browserSync.reload({ stream: true }))
  )

  # stylus
  gulp.watch(paths.stylus).on('change', (e) ->
    filename = e.path.replace(__dirname + '/src/stylus/', '')
    srcPath = e.path.replace(__dirname + '/', '')
    destPath = e.path.replace(__dirname + '/src/stylus', paths.cssDir).replace('/' + filename, '')
    gutil.log('Stylus file changed.')
    gulp.src(srcPath)
      .pipe(stylus(
          use: [ nib() ]
        ).on('error', errorHandler))
      .pipe(gulp.dest(destPath))
      .pipe(browserSync.reload({ stream: true }))
  )
  # jade
  gulp.watch(paths.jade, ['jade'])
  gulp.watch(paths.html).on('change', () ->
    browserSync.reload()
  )
  cb()
)


###
 command
###
#
gulp.task('default', [
  'browser-sync-silent'
  'jade'
  'coffee'
  'coffee-spec'
  'stylus'
  'watch'
  'tdd'
])
gulp.task('default', [
  'browser-sync'
  'jade'
  'coffee'
  'coffee-spec'
  'stylus'
  'watch'
  'tdd'
])

gulp.task('deploy', [
  'jade-before-build'
  'jade'
  'coffee'
  'coffee-spec'
  'stylus'
  'copy'
])
gulp.task('sprite', [
  'sprite-base'
])

