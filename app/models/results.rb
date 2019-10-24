require_relative 'player'
require_relative 'go_fish'
require 'pry'

class Results
  attr_reader :game
  attr_accessor :player_results

  def initialize(inquiring_player, inquired_player, rank)
    @player_results = 
    { take_message: "#{inquiring_player} took a #{rank} from #{inquired_player}", 
      go_fish_message: "#{inquiring_player} asked for a #{rank} from #{inquired_player} but had to Go Fish", 
      fished_asked_rank_message: "#{inquiring_player} fished what #{inquiring_player} asked for, take another turn" 
    }
  end
end