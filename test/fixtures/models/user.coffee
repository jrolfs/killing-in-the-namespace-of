class ModuleA.Models.User extends ModuleA.Models.Base

  initialize: (options)->
    @config = _.merge({name: "Charles"}, options)
