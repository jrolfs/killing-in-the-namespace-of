Backbone = require('backbone')
User = require('../models/user')

class Users extends Backbone.Collection
  model: User

module.exports = Users
