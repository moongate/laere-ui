module.exports = (grunt) ->
  pkg = grunt.file.readJSON('package.json')

  # Project configuration.
  grunt.initConfig
    relativePath: 'dev'

  # Tasks
    clean:
      main: ['build', 'tmp-deploy']

    copy:
      main:
        files: [
          expand: true
          cwd: 'src/'
          src: ['**', '!script/**', '!**/*.less']
          dest: 'build/<%= relativePath %>/'
        ]

    coffee:
      main:
        files: [
          expand: true
          cwd: 'src/script'
          src: ['**/*.coffee']
          dest: 'build/<%= relativePath %>/script/'
          ext: '.js'
        ]

    less:
      main:
        files: [
          expand: true
          cwd: 'src/style'
          src: ['main.less']
          dest: 'build/<%= relativePath %>/style/'
          ext: '.css'
        ]

    uglify:
      options:
        mangle: false

    ngtemplates:
      main:
        cwd: 'src/'
        src: 'views/**/*.html',
        dest: 'build/<%= relativePath %>/script/templates.js'
        options:
          module: 'laere'
          htmlmin:  collapseWhitespace: true, collapseBooleanAttributes: true

    useminPrepare:
      html: 'build/<%= relativePath %>/index.html'
      options:
        dest: 'build/'
        root: 'build/'

    usemin:
      html: ['build/<%= relativePath %>/index.html']

    karma:
      options:
        configFile: 'karma.conf.coffee'
      unit:
        background: true
      single:
        singleRun: true

    connect:
      server:
        options:
          livereload: true
          hostname: "*"
          port: 80
          middleware: (connect, options) ->
            proxy = require("grunt-connect-proxy/lib/utils").proxyRequest
            index = (req, res, next) -> (req.originalUrl = req.url = '/dev/index.html' if req.originalUrl is '/'); next()
            [index, proxy, connect.compress(), connect.static('./build/')]
        proxies: [
          context: ['/', '!/dev']
          host: 'laere.co'
        ]

    watch:
      options:
        livereload: true
        spawn: false
      coffee:
        files: ['src/script/**/*.coffee']
        tasks: ['coffee']
      less:
        files: ['src/style/**/*.less']
        tasks: ['less']
      ngtemplates:
        files: ['src/views/**/*.html']
        tasks: ['ngtemplates']
      main:
        files: ['src/i18n/**/*.json', 'src/index.html']
        tasks: ['copy']
      test:
        files: ['src/script/**/*.coffee', 'spec/**/*.coffee']
        tasks: ['karma:unit:run']

  grunt.loadNpmTasks name for name of pkg.devDependencies when name[0..5] is 'grunt-'

  grunt.registerTask 'default', ['clean', 'copy', 'coffee', 'less', 'ngtemplates', 'server', 'watch']
  grunt.registerTask 'tdd', ['clean', 'copy', 'coffee', 'less', 'ngtemplates', 'karma:unit', 'server', 'watch']
  grunt.registerTask 'min', ['useminPrepare', 'concat', 'uglify', 'usemin'] # minifies files
  grunt.registerTask 'dist', ['clean', 'copy', 'coffee', 'less', 'ngtemplates', 'min'] # Dist - minifies files
  grunt.registerTask 'devmin', ['dist', 'configureProxies:server', 'connect:server:keepalive'] # Minifies files and serve
  grunt.registerTask 'test', ['karma:single']
  grunt.registerTask 'server', ['configureProxies:server', 'connect']
