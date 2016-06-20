require 'test_helper'

class KitnoTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Kitno::VERSION
  end

  def test_it_properly_maps_dependencies_on_a_dry_run
    kitno = ::Kitno::KillingInTheNamespaceOf.new(
      namespace: 'RootNamespace',
      directory: 'test/fixtures',
      globals: '',
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
          'RootNamespace.Models.Base',
        ]
      }
    }
    actual = nil

    assert_silent { actual = kitno.enumerate }
    assert_equal expected, actual, 'The class map generated was incorrect'
  end
end
