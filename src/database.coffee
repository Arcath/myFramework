Waterline = require 'waterline'

waterline = new Waterline()

module.exports =
  ready: false

  init: (config, cb) ->
    #waterline.loadCollection(ModelName)

    _db = this
    waterline.initialize config, (err, models) ->
      _db.ready = true

      if err
        throw "Waterline Error #{err}"

      cb(models)
