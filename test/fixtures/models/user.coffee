class RootNamespace.Models.User extends RootNamespace.Models.Base
  initialize: (options = {}) ->
    @foo = $.merge(true, { bar: 'baz' }, options.foo)
    @config = _.merge({ name: 'Charles' }, options)
