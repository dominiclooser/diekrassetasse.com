time = require 'time-grunt'
jit = require 'jit-grunt'
autoprefixer = require 'autoprefixer'

config =
    exec: 
        'harp': 'harp compile'
   'gh-pages':
        production:
            options:
                base: 'www'
            src: '**/*'
        stage:
            options:
                base: 'www'
                repo: 'git@github.com:dominiclooser/stage.diekrassetasse.com.git'
            src: '**/*'
    postcss:
        options:
            processors:
                autoprefixer
                    browers: 'last 2 versions'
        dist:
            src: 'www/styles/styles.css'
    copy:
        'production-cname':
            src: 'cname/production'
            dest: 'www/CNAME'
        'stage-cname':
            src: 'cname/stage'
            dest: 'www/CNAME'
        
    stylus:
        main:
            src: 'styles/styles.styl'
            dest: 'www/styles/styles.css'
    yaml:
        main:
            expand: true
            src: '_*.yml'
            ext: '.json'
    watch:
        options:
            livereload: true
        yaml:
            files: ['**/*.yml']
            tasks: ['yaml']
        all:
            files: ['**/*.*']
            tasks: []

module.exports = (grunt) ->
    grunt.initConfig config
    time grunt
    jit grunt
    grunt.registerTask 'default', ['yaml', 'watch']
    grunt.registerTask 'compile', ['yaml', 'exec:harp']
    grunt.registerTask 'production', ['compile','copy:production-cname', 'gh-pages:production']
    grunt.registerTask 'stage', ['compile', 'copy:stage-cname', 'gh-pages:stage']
