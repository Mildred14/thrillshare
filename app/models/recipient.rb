class Recipient < ApplicationRecord
  belongs_to :school

  validates :name, presence: true
end
