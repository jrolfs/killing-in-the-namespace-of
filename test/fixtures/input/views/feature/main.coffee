class RootNamespace.Views.Feature.Main extends RootNamespace.Views.Base
  constructor: (options = {}) ->
    @model ||= new RootNamespace.Models.User(name: options.name)
    @friend = new RootNamespace.Models.User(name: options.friend.name)
    super

  render: ->
    @$thing = $('.thing')
    @$other = $('.other')
