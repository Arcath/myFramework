React = require 'react'

module.exports = React.createClass
  render: ->
    React.createElement(
      "html"
      {}
      React.createElement(
        "head"
        {}
        React.createElement("title", {}, "Page Title")
        React.createElement("link", {href: '/assets/bundle.css', rel: 'stylesheet'})
      )
      React.createElement(
        "body"
        {}
        @props.children
        React.createElement('script', {src: '/assets/bundle.js'})
      )
    )
