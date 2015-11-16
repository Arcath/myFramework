Express = require 'express'

router = Express.Router()

router.get '/', (req, res) ->
  res.render('index/index')

module.exports = router
