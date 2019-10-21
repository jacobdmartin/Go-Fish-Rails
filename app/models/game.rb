class Game < ApplicationRecord
  # serialize:  :data GoFish
  validates :name,  presence: true, length: { maximum: 50 }, uniqueness: true

  has_many :game_users

  # def to_json
  #   return nil if json.blank?
  #   values = JSON.parse(json)
  #   go_fish.new(values[“name”])
  # end

  # def self.from_json
  #   {
  #   name: go_fish_game.name,
  #   results: go_fish_game.results.as_json
  #   }.to_json
  # end
end
