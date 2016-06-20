class ModuleA.User extends ModuleA.Model
  
  initialize: (options)->
    @config = _.merge({name: "Charles"}, options)
