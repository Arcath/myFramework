path = require 'path'
SailsMemory = require 'sails-memory'

Launcher = require(path.join(__dirname, '..', 'src', 'launcher'))

mway = Launcher.Motorway

global.app = Launcher.Application
global.Database = Launcher.Database
global.dbConf = {
  adapters: {
    memory: SailsMemory
  }

  connections: {
    default: {
      adapter: 'memory'
    }
  }
}

describe 'Test init', ->
  it 'should init good', (done) ->
    launch = mway.junctions.findOne({name: 'launch'})

    mway.addJunction 'test', launch.runAfter

    mway.addAction 'test', ->
      done()
      @rejoin()

    mway.dropJunction 'launch'
    mway.start 'init'
