# Compiled by browserify to assets/bundle.js
React = require 'react'

Client = require 'react-engine/lib/client'

require('./views/**/*.coffee', {mode: 'expand'})

options = {
  viewResolver: (viewName) ->
    require('./views/' + viewName)
}

document.addEventListener 'DOMContentLoaded', ->
  Client.boot options
