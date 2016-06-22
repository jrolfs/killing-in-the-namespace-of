require 'test_helper'
require 'fileutils'

class KitnoTest < Minitest::Test
  def setup
    @options = {
      namespace: 'RootNamespace',
      directory: 'test/fixtures/input',
      output: 'test/fixtures/output',
      globals: '_:underscore,$:jquery',
      externals: 'Backbone:backbone,Brainstem:brainstem'
    }

    @kitno = ::Kitno::KillingInTheNamespaceOf.new(@options)
  end

  def test_it_has_a_version_number
    refute_nil ::Kitno::VERSION
  end

  def test_it_properly_maps_dependencies_on_dry_run
    expected = {
      'test/fixtures/input/models/base.coffee' => {
        path: 'test/fixtures/input/models/base.coffee',
        class_name: 'RootNamespace.Models.Base',
        dependencies: ['brainstem']
      },
      'test/fixtures/input/models/user.coffee' => {
        path: 'test/fixtures/input/models/user.coffee',
        class_name: 'RootNamespace.Models.User',
        dependencies: [
          'underscore',
          'jquery',
          'RootNamespace.Models.Base'
        ]
      },
      'test/fixtures/input/views/base.coffee' => {
        path: 'test/fixtures/input/views/base.coffee',
        class_name: 'RootNamespace.Views.Base',
        dependencies: ['backbone']
      },
      'test/fixtures/input/views/feature/main.coffee' => {
        path: 'test/fixtures/input/views/feature/main.coffee',
        class_name: 'RootNamespace.Views.Feature.Main',
        dependencies: [
          'jquery',
          'RootNamespace.Views.Base',
          'RootNamespace.Models.User'
        ]
      }

    }
    actual = nil

    assert_silent { actual = @kitno.enumerate }
    assert_equal expected, actual, 'The class map generated was incorrect'
  end

  def test_it_properly_writes_dependencies_on_run
    FileUtils.rmtree('test/fixtures/output')

    @kitno.run

    Find.find('test/fixtures/expected_output') do |path|
      next if FileTest.directory?(path)

      expected = File.open(path, 'rb').read
      actual = File.open(Pathname.new(path).sub('expected_output', 'output').sub('.module', ''), 'rb').read

      assert_equal expected, actual, 'The outputted module content was incorrect'
    end
  end
end
