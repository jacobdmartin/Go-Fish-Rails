require 'rails_helper'
require_relative '../../app/models/game'
require_relative '../../app/models/playing_card'
require_relative '../../app/models/player'

RSpec.describe Game, type: :model do
  let(:game) { Game.create(name: "Game")}

  let(:five_of_diamonds) { PlayingCard.new("5", "Diamonds")}
  let(:eight_of_hearts) { PlayingCard.new("8", "Hearts")}
  let(:eight_of_diamonds) { PlayingCard.new("8", "Diamonds")}
  let(:king_of_hearts) { PlayingCard.new("King", "Hearts")}
  
  let(:bill) { Player.new("Bill")}
  let(:connie) { Player.new("Connie")}

  before do
    @go_fish_game = GoFish.new(game.name)
    @go_fish_game.start
    @go_fish_game.results = ["Bill took a 8 from Connie", "Bill asked for a 9 from Connie but had to Go Fish"]
    @go_fish_game.card_deck.card_deck = [five_of_diamonds, eight_of_hearts]
    @go_fish_game.players = [bill, connie]
    @go_fish_game.players[0].hand = [eight_of_diamonds]
    @go_fish_game.players[1].hand = [eight_of_hearts]
    @go_fish_game.players[1].completed_matches = ["King"]
    @go_fish_game.take_turn(bill, connie, "8")
    game.go_fish = @go_fish_game #serializing the go fish game into json
    @inflated_game = game.go_fish #inflating the go fish game from json
  end

  describe 'as_json' do
    describe 'name' do
      it 'expects the name of the GoFish game to stay the same when loaded from json' do
        expect(@inflated_game.name).to eq(@go_fish_game.name)
      end
    end

    describe 'card_deck_to_object' do
      it 'expects the card deck inflation to stay the same loaded from json' do
        expect(@inflated_game.card_deck).to eq(@go_fish_game.card_deck)
      end
    end

    describe 'players_to_object' do
      it 'expects the players array of the GoFish game to stay the same when loaded from json' do
        expect(@inflated_game.players).to eq(@go_fish_game.players)
      end
    end

    describe 'results_to_object' do      
      it 'expects the results of the GoFish game to stay the same when loaded from json' do
        expect(@inflated_game.results).to eq(@go_fish_game.results)
      end
    end
    
    describe 'current_player_to_object' do
      it 'expects the current_player of the GoFish gae to stay the same when loaded from json' do
        expect(@inflated_game.current_player).to eq(@go_fish_game.current_player)
      end
    end
  end
end