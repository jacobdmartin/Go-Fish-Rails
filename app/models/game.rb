class Game < ApplicationRecord
  attr_accessor :player_num, :players, :hand
  serialize :go_fish, GoFish
  validates :name,  presence: true, length: { maximum: 50 }, uniqueness: true

  has_many :game_users
end
