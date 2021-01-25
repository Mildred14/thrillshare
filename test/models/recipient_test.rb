require 'test_helper'

class RecipientTest < ActiveSupport::TestCase
  test "validate recipient" do
    recipient = Recipient.new
    
    refute recipient.save

    school = schools(:school)
    recipient.name = "Mildred Silva"
    recipient.address = "Av. Hidalgo"
    recipient.school = school

    assert recipient.save
  end
end
