require 'test_helper'

class KitnoTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Kitno::VERSION
  end

  def test_it_properly_maps_dependencies_on_enumeration
    kitno = ::Kitno::KillingInTheNamespaceOf.new(
      namespace: 'RootNamespace',
      directory: 'test/fixtures',
      globals: '_:underscore,$:jquery',
      externals: 'Brainstem:brainstem'
    )

    expected = {
      'test/fixtures/models/base.coffee' => {
        path: 'test/fixtures/models/base.coffee',
        class_name: 'RootNamespace.Models.Base',
        dependencies: ['brainstem']
      },
      'test/fixtures/models/user.coffee' => {
        path: 'test/fixtures/models/user.coffee',
        class_name: 'RootNamespace.Models.User',
        dependencies: [
          'underscore',
          'jquery',
          'RootNamespace.Models.Base'
        ]
      },
      'test/fixtures/views/base.coffee' => {
        path: 'test/fixtures/views/base.coffee',
        class_name: 'RootNamespace.Views.Base',
        dependencies: []
      },
      'test/fixtures/views/feature/main.coffee' => {
        path: 'test/fixtures/views/feature/main.coffee',
        class_name: 'RootNamespace.Views.Feature.Main',
        dependencies: [
          'jquery',
          'RootNamespace.Views.Base',
          'RootNamespace.Models.User'
        ]
      }

    }
    actual = nil

    assert_silent { actual = kitno.enumerate }
    assert_equal expected, actual, 'The class map generated was incorrect'
  end
end
