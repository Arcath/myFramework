BodyParser = require 'body-parser'
Express = require 'express'
Motorway = require 'motorway'
path = require 'path'
ReactEngine = require 'react-engine'

Database = require './database'
SailsPostgres = require 'sails-postgresql'
global.dbConf = {
  adapters: {
    postgres: SailsPostgres
  }

  connections: {
    default: {
      adapter: 'postgres'
      url: process.env['DATABASE_URL']
    }
  }
}

IndexRouter = require './routers/index'

app = Express()
engine = null
mway = new Motorway()

mway.addJunction 'init'
mway.addJunction 'configure', ['init']
mway.addJunction 'launch', ['configure']

mway.addAction 'init', ->
  engine = ReactEngine.server.create({})

  @rejoin()

mway.addAction 'init', ->
  _runner = this
  Database.init global.dbConf, (models) ->
    app.models = models.collections
    _runner.rejoin()

mway.addAction 'configure', ->
  app.engine('.coffee', engine)

  app.set('view engine', 'coffee')
  app.set('view cache', false)
  app.set('views', path.join(__dirname, 'views'))
  app.set('view', ReactEngine.expressView)

  app.use BodyParser.urlencoded({ extended: false })
  app.use BodyParser.json()

  app.use '/assets', Express.static('assets')
  app.use '/', IndexRouter

  @rejoin()

mway.addAction 'launch', ->
  app.listen 3000, ->
    console.log 'listening on port 3000'


module.exports = {Motorway: mway, Application: app, Database: Database}
