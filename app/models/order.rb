class Order < ApplicationRecord
  belongs_to :school
  enum status: %i[processing shipped received cancelled]

  VALID_GIFTS = %w[mug t-shirt sticker hoodie].freeze

  validates :recipient_ids, :gifts, length: { minimum: 1 }
  validate :valid_gifts
  validate :max_limit_recipients, on: %i[create update], if: proc { school_id.present? }
  validate :max_limit_gifts, on: %i[create update], if: proc { school_id.present? }
  validate :recipients_from_school, on: %i[create update], if: proc { school_id.present? }

  RECIPIENTS_LIMIT = 20
  GIFTS_PER_DAY_LIMIT = 60

  scope :not_cancelled, -> { where.not(status: :cancelled) }

  def max_limit_recipients
    recipents_set = Set.new(recipient_ids)

    errors.add(:recipient_ids, "allow up to #{RECIPIENTS_LIMIT}") if recipents_set.size > RECIPIENTS_LIMIT
  end

  def max_limit_gifts
    orders = school.orders.not_cancelled.where("created_at::date = ?", Date.current)
    total = orders.inject(gifts.size * recipient_ids.size) do |res, order|
      res + (order.gifts.size * order.recipient_ids.size)
    end

    errors.add(:school, "allow up to #{GIFTS_PER_DAY_LIMIT}") if total > GIFTS_PER_DAY_LIMIT
  end

  def recipients_from_school
    valid_ids = school.recipients.where(id: recipient_ids).pluck(:id)
    errors.add(:recipient_ids, "there are invalid ids") if (recipient_ids.map(&:to_i) - valid_ids).any?
  end

  def valid_gifts
    errors.add(:recipient_ids, "there are invalid gifts") if (gifts - VALID_GIFTS).any?
  end
end
