require 'test_helper'

class SchoolTest < ActiveSupport::TestCase

  test "validate school" do
    school = School.new

    refute school.save

    school.name = "Universidad de Colima"
    school.address = "Av. Universidad"

    assert school.valid?
  end
end
