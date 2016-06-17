require 'thor'

module Kitno
  class CLI < Thor
    desc 'enumerate', 'Enumrate files that will be transformed'
    long_desc <<-ENUMERATE
    ENUMERATE

    option :namespace, aliases: '-n', type: :string, required: true, desc: 'Base namespace to migrate from'
    option :directory, aliases: '-d', type: :string, default: '.', desc: 'Directory to target for transformation'
    def enumerate
      KillingInTheNamespaceOf.new(options).enumerate
    end
  end
end
