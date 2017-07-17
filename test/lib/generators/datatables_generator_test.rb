require 'test_helper'
require 'generators/datatables/datatables_generator'

class DatatablesGeneratorTest < Rails::Generators::TestCase
  tests DatatablesGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
