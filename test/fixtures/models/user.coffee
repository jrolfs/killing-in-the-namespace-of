class RootNamespace.Models.User extends RootNamespace.Models.Base

  initialize: (options)->
    @config = _.merge({name: "Charles"}, options)
