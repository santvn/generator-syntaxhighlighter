path = require 'path'
rimraf = require 'rimraf'
helpers = require('yeoman-generator').test

describe 'brush', ->
  beforeEach (done) ->
    helpers.testDirectory path.join(__dirname, 'brush-test'), (err) =>
      return done(err) if err
      @target = helpers.createGenerator 'syntaxhighlighter:brush', ['../../brush']
      done()

  afterEach (done) ->
    rimraf "#{__dirname}/brush-test", done

  it 'creates expected files', (done) ->
    helpers.mockPrompt @target,
      moduleName: 'JavaScript'

    @target.options['skip-install'] = true

    @target.run {}, ->
      helpers.assertFile """
        package.json
        Gruntfile.coffee
        README.md
        karma.conf.coffee
        .gitignore
        .travis.yml
        lib/brush-javascript.js
        test/brush-javascript.spec.coffee
        test/shcore-stub.js
      """.split /\s+/g
      done()