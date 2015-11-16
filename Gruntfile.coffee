path = require 'path'

module.exports = (grunt) ->
  grunt.loadNpmTasks('grunt-shell')
  grunt.loadNpmTasks('grunt-browserify')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-concurrent')

  grunt.initConfig
    browserify:
      main:
        files:
          'assets/bundle.js': ['src/bundle.coffee']
        options:
          transform: ['coffeeify', 'require-globify']
          external: 'react-router'

    concurrent:
      app:
        tasks: ['watch:less', 'watch:src', 'shell:launch']
        options:
          logConcurrentOutput: true

    shell:
      launch:
        command: 'node index.js'

      test:
        command: "#{path.join('node_modules', '.bin', 'mocha')} #{path.join('tests', '*.coffee')} #{path.join('tests', '**', '*.coffee')} -r coffee-script/register -c"

      coverage:
        command: "#{path.join('node_modules', '.bin', 'mocha')} #{path.join('tests', '**', '*.coffee')} -r ./support/coffee-coverage.js -R html-cov >> lcov.html"

      openCoverage:
        command: 'lcov.html'

      less:
        command: "#{path.join('node_modules', '.bin', 'lessc')} #{path.join('less', 'main.less')} #{path.join('assets', 'bundle.css')}"

      rmLcov:
        command: "del lcov.html"

    watch:
      less:
        files: ['less/**/*.less']
        tasks: ['shell:less']
        options:
          interrupt: true

      src:
        files: ['src/**/*.coffee']
        tasks: ['browserify:main']
        options:
          interrupt: true

  grunt.registerTask 'default', ['browserify', 'shell:less', 'concurrent:app']
  grunt.registerTask 'test', ['browserify', 'shell:less', 'shell:test']
  grunt.registerTask 'coverage', ['shell:rmLcov', 'browserify', 'shell:less', 'shell:coverage', 'shell:openCoverage']
