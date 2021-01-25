require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  def setup
    @school = schools(:school)
    @recipient = recipients(:mildred)
  end

  test "validate order" do
    order = Order.new

    refute order.valid?

    order.gifts << "mug"
    order.recipient_ids << "1"
    order.school = @school

    refute order.valid?

    order.recipient_ids = [@recipient.id]

    assert order.valid?

    order.gifts = ["invalid"]

    refute order.valid?
  end

  test "max limit of recipients" do
    recipients = []
    20.times do |i|
      r = @school.recipients.create(name: "Name #{i}", address: "Address #{i}")
      recipients << r.id
    end

    order = @school.orders.new(gifts: %w[mug], recipient_ids: [@recipient.id, *recipients])

    refute order.valid?

    order.recipient_ids = recipients

    assert order.valid?
  end

  test "max limit gifts" do
    recipients = [@recipient.id]
    19.times do |i|
      r = @school.recipients.create(name: "Name #{i}", address: "Address #{i}")
      recipients << r.id
    end

    order = @school.orders.build(gifts: %w[mug t-shirt sticker], recipient_ids: recipients)

    assert order.valid?

    order.gifts << "hoodie"

    refute order.valid?
  end

  test "recipients from school" do
    school_2 = School.create(name: "Other school", address: "School address")
    recipient_2 = school_2.recipients.create(name: "Other recipient", address: "Recipient address")

    order = Order.new(school: @school, gifts: %w[mug], recipient_ids: [@recipient.id])

    assert order.valid?

    order.school = school_2

    refute order.valid?

    order.recipient_ids = [recipient_2.id]

    assert order.valid?
  end
end
