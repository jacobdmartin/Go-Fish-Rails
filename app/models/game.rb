class Game < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 50 }, uniqueness: true

  belongs_to :game_users
  has_many :game_users
end
