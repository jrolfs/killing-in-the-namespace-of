require 'thor'

module Kitno
  class CLI < Thor
    desc 'enumerate', 'Enumrate files that will be transformed'
    long_desc <<-ENUMERATE
    ENUMERATE

    option :namespace, aliases: '-n', type: :string, required: true, desc: 'Base namespace to migrate from'
    option :directory, aliases: '-d', type: :string, default: '.', desc: 'Directory to target for transformation'
    option :globals, aliases: '-g', type: :string, desc: <<-GLOBALS
      A comma separated list of global methods in the form of `global:dependency`.
      Example: '_:underscore,$:jquery'
    GLOBALS
    option :externals, aliases: '-e', type: :string, desc: <<-EXTERNALS
      A comma separated list of external dependencies in the form of `constructor:dependency`.
      Example: 'Module.Dependency:module#Dependency,Module.Foo.Dependency:module/foo#Dependency'
    EXTERNALS
    def enumerate
      KillingInTheNamespaceOf.new(options).enumerate
    end
  end
end
