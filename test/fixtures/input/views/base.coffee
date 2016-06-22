class RootNamespace.Views.Base extends Backbone.View
  render: ->
    @$foo = @$('.foo')
    super
