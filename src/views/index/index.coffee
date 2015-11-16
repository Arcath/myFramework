React = require 'react'
Layout = require '../layouts/main.coffee'

module.exports = React.createClass({
  onButtonClick: ->
    alert 'Hello'

  render: ->
    React.createElement(
      Layout
      @props
      React.createElement(
        'div',
        {},
        "Hello ",
        React.createElement(
          'button',
          {onClick: @onButtonClick},
          "click on me please!!!"
        )
      )
    )
})
