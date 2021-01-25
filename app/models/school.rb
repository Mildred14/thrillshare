class School < ApplicationRecord
  has_many :recipients
  has_many :orders

  validates :name, :address, presence: true
end
