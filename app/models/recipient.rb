class Recipient < ApplicationRecord
  belongs_to :school

  validates :name, :address, presence: true
end
