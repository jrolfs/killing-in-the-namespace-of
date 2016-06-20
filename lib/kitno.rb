require 'kitno/version'
require 'kitno/cli'

require 'find'
require 'fileutils'

module Kitno
  class KillingInTheNamespaceOf
    CLASS_EXPRESSION = /^class\s(?:@)?([A-Z][\w\.]*)/
    REQUIRE_TEMPLATE = "%{short_name} = require('%{path}')"

    def initialize(options = {})
      @namespace, @directory, globals, externals = options.values_at(:namespace, :directory, :globals, :externals)

      @class_map = {}
      @files = []

      @globals = parse_mappings(globals) if globals && globals.length > 0

      @externals = parse_mappings(externals) if externals && externals.length > 0

      @dependency_expression = /^(?!(\s\*|#)).*(?:new|extends)\s(#{Regexp.escape(@namespace)}[\w\.]*)/
    end

    def run
      enumerate_files

      @class_map.each_value do |descriptor|
        path = descriptor[:path]

        require_dependencies!(path, descriptor[:dependencies])

        FileUtils.mv "#{path}.module", path
      end
    end

    def enumerate
      enumerate_files
    end

    private

    def enumerate_files
      Find.find(@directory) do |path|
        if FileTest.directory?(path)
          next
        elsif path.match(/\.coffee$/).nil?
          Find.prune
        end

        @files << path

        contents = File.open(path, 'rb').read

        class_name = parse_class_name contents
        dependencies = parse_dependencies contents

        unless class_name.nil?
          @class_map[path] = {
            path: path,
            class_name: class_name,
            dependencies: dependencies
          }
        end
      end
    end

    def parse_mappings(mappings)
      mappings.split(',').reduce({}) do |map, mapping|
        constructor, dependency = mapping.split(':')
        map[constructor] = dependency
        map
      end
    end

    def parse_class_name(contents)
      match = CLASS_EXPRESSION.match(contents)

      match[1] if match
    end

    def parse_dependencies(contents)
      dependencies = contents.scan(@dependency_expression).flatten

      if @globals && !@globals.empty?
        @globals.each do |global, dependency|
          dependencies << dependency if contents.scan(/\b#{Regexp.escape(global)}\./).length > 0
        end
      end

      if @externals && !@externals.empty?
        @externals.each do |external, dependency|
          dependencies << dependency if contents.scan(/\b#{Regexp.escape(external)}\./).length > 0
        end
      end

      dependencies.compact
    end

    def get_descriptor(class_name)
      @class_map.select{ |k, v| v[:class_name] == class_name }.values.first
    end

    def get_directory(path)
      path.split('/')[0...-1].join('/')
    end

    def get_module_mappings(filename, descriptor)
      path = descriptor[:path]
      class_name = descriptor[:class_name]
      short_name = class_name.split('.').last

      path_directory = Pathname.new(get_directory(path))
      filename_directory = Pathname.new(get_directory(filename))

      relative_directory = path_directory.relative_path_from(filename_directory).to_s
      relative_path = "#{relative_directory}/#{path.split('/').pop().split('.').shift}"

      return relative_path, short_name
    end

    def require_dependencies!(filename, dependencies)
      File.open("#{filename}.module", 'w') do |file|
        dependencies.each do |dependency|
          relative_path, short_name = get_module_mappings(filename, get_descriptor(dependency))

          file.puts REQUIRE_TEMPLATE % { short_name: short_name, path: relative_path }
        end

        file.puts "\n\n"

        short_class_name = @class_map[filename][:class_name].split('.').last

        File.foreach(filename) do |line|
          line.gsub!(CLASS_EXPRESSION, "class #{short_class_name}")

          dependencies.each do |dependency|
            descriptor = get_descriptor(dependency)
            class_name = descriptor[:class_name]
            relative_path, short_name = get_module_mappings(filename, descriptor)

            line.gsub!(class_name, short_name)
          end

          file.puts line
        end

        file.puts "\nmodule.exports = #{short_class_name}\n"
      end
    end
  end
end
