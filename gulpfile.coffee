gulp = require 'gulp'
connect = require 'connect'
httpProxy = require 'http-proxy'
harp = require 'harp'
http = require 'http'
livereload = require 'gulp-livereload'
server = livereload()
proxy = httpProxy.createProxyServer()

LAERE_PORT = 1337

proxyMiddleware = (req, res) ->
  # We wish to proxy to the production API
  if not gulp.env.local
    req.headers.host = req.headers.host.replace("laeredev.co", "laere.co")
  proxy.web req, res, target: "http://" + req.headers.host.replace(LAERE_PORT, 80)

gulp.task "connect", ["watch"], ->
  app = connect()
    .use(connect.logger('dev'))
    .use(harp.mount('./src'))
    .use(connect.logger('proxy :: :method :url :status - :response-time ms'))
    .use(proxyMiddleware) # If not found, proxy to api

  http.createServer(app).listen(LAERE_PORT)

gulp.task "watch", ->
  gulp.watch("src/**").on "change", (e) -> server.changed(e.path)

gulp.task "default", ["connect"]