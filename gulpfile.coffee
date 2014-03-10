gulp = require 'gulp'
connect = require 'connect'
proxy = require 'proxy-middleware'
harp = require 'harp'
http = require 'http'
url = require 'url'
livereload = require 'gulp-livereload'
server = livereload()

files = ["script/**", "spec/**", "style/**", "views/**", "i18n/**",  "img/**", "index.html"]

gulp.task "connect", ["watch"], ->
  app = connect()
    .use(connect.logger('dev'))
    .use(harp.mount(__dirname + '/'))
    .use('/', proxy url.parse 'http://www.laere.co') # If not found, proxy to api

  http.createServer(app).listen(1337)

gulp.task "watch", ->
  gulp.watch(files).on "change", (e) -> server.changed(e.path)

gulp.task "default", ["connect"]