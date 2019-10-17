require_relative 'player'
require_relative 'go_fish'

class Results
  attr_reader :game
  attr_accessor :player_results

  def initialize(inquiring_player, inquired_player, rank)
    @player_results = 
    { take_message: "#{inquiring_player.name} took a #{rank} from #{inquired_player.name}", 
      go_fish_message: "#{inquiring_player.name} asked for a #{rank} from #{inquired_player.name} but had to Go Fish", 
      fished_asked_rank_message: "#{inquiring_player.name} fished what #{inquiring_player.name} asked for, take another turn" 
    }
  end
end