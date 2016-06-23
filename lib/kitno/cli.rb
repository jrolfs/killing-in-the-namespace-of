require 'thor'
require 'awesome_print'

module Kitno
  class CLI < Thor
    desc 'transform', 'Transform directory of modules from namespace convention to CommonJS modules'
    long_desc <<-TRANSFORM
    TRANSFORM

    option :dry, type: :boolean, default: false, desc: 'Performs a dry run, printing out the dependency map generated'
    option :namespace, aliases: '-n', type: :string, required: true, desc: 'Base namespace to migrate from'
    option :directory, aliases: '-d', type: :string, default: '.', desc: 'Directory to target for transformation'
    option :output, aliases: '-o', type: :string, default: './output', desc: 'Directory to output transformed modules'
    option :globals, aliases: '-g', type: :string, desc: <<-GLOBALS
      A comma separated list of global methods in the form of `global:dependency`.
      Example: '_:underscore,$:jquery'
    GLOBALS
    option :externals, aliases: '-e', type: :string, desc: <<-EXTERNALS
      A comma separated list of external dependencies in the form of `constructor:dependency`.
      Example: 'Module.Dependency:module#Dependency,Module.Foo.Dependency:module/foo#Dependency'
    EXTERNALS
    def transform
      kitno = KillingInTheNamespaceOf.new(options)

      if options[:dry]
        ap kitno.enumerate
      else
        kitno.run
      end
    end
  end
end
