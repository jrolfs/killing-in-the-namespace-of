require 'test_helper'

class KitnoTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Kitno::VERSION
  end

  def test_it_properly_maps_dependencies_on_a_dry_run
    kitno = ::Kitno::KillingInTheNamespaceOf.new(
      namespace: 'ModuleA',
      directory: 'test/fixtures',
      globals: '',
      externals: 'Brainstem:brainstem'
    )

    kitno.enumerate()

    expected = {
      'test/fixtures/models/modulea-model.coffee' => {
        path: 'test/fixtures/models/modulea-model.coffee',
        class_name: 'ModuleA.Models.Base',
        dependencies: ['brainstem']
      },
      'test/fixtures/models/modulea-user.coffee' => {
        path: 'test/fixtures/models/modulea-user.coffee',
        class_name: 'ModuleA.Models.User',
        dependencies: ['ModuleA.Models.Base']
      }
    }

    actual = kitno.class_map
    assert_equal expected, actual, 'The class map generated was incorrect'
  end
end
