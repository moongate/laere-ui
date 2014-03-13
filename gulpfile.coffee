gulp = require 'gulp'
connect = require 'connect'
httpProxy = require 'http-proxy'
harp = require 'harp'
http = require 'http'
url = require 'url'
livereload = require 'gulp-livereload'
server = livereload()
laerehost = if gulp.env.local then 'laeredev.co' else 'laere.co'
target =
  host: laerehost
  port: 80
proxy = httpProxy.createProxyServer(target: target)
proxyMiddleware = (req, res) -> proxy.web req, res

gulp.task "connect", ["watch"], ->
  app = connect()
    .use(connect.logger('dev'))
    .use(harp.mount('./src'))
    .use(connect.logger('proxy :: :method :url :status - :response-time ms'))
    .use(proxyMiddleware) # If not found, proxy to api

  http.createServer(app).listen(1337)

gulp.task "watch", ->
  gulp.watch("src/**").on "change", (e) -> server.changed(e.path)

gulp.task "default", ["connect"]