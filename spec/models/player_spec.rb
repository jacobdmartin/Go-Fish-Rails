require_relative '../../app/models/go_fish'
require_relative '../../app/models/player'
require_relative '../../app/models/playing_card'


RSpec.describe Player, type: :model do
  let(:audrey) {Player.new("Audrey")}
  let(:jonathan) {Player.new("Jonathan")}

  let(:five_of_hearts) {PlayingCard.new("5", "Hearts")}
  let(:eight_of_diamonds) {PlayingCard.new("8", "Diamonds")}
  let(:five_of_spades) {PlayingCard.new("5", "Spades")}
  let(:five_of_diamonds) {PlayingCard.new("5", "Diamonds")}
  let(:five_of_clubs) {PlayingCard.new("5", "Clubs")}
  let(:seven_of_hearts) {PlayingCard.new("7", "Hearts")}

  let(:game) {GoFish.new}

  def create_and_start_game
    game.add_player(audrey)
    game.add_player(jonathan)
    game.start
  end

  describe '#add_cards_to_hand' do
    it 'adds a card to a players hand' do
      create_and_start_game
      game.players[0].hand = [five_of_hearts]
      game.players[0].add_cards_to_hand(eight_of_diamonds)
      expect(game.players[0].hand.count).to eq 2
    end
  end

  describe '#unique_ranks' do
    it 'returns one unique rank of each of the players ranks in hand' do
      create_and_start_game
      game.players[0].hand = [five_of_clubs, eight_of_diamonds, five_of_diamonds]
      expect(game.players[0].unique_ranks).to eq ["5", "8"]
    end
  end

  describe '#has_rank?' do
    it 'returns true if the player has the rank asked for' do
      create_and_start_game
      game.players[0].hand = [five_of_clubs, eight_of_diamonds]
      expect(game.players[0].has_rank?(five_of_hearts.rank)).to eq true    
    end

    it 'returns false if the player does not have the rank asked for' do
      create_and_start_game
      game.players[0].hand = [five_of_clubs, eight_of_diamonds]
      expect(game.players[0].has_rank?(seven_of_hearts.rank)).to eq false
    end
  end

  describe '#count_matches' do
    it 'removes the card from the players hand' do
      create_and_start_game
      game.players[0].hand = [five_of_clubs, five_of_diamonds, five_of_hearts, five_of_spades]
      game.players[0].count_matches
      expect(game.players[0].hand.count).to eq 0
      expect(game.players[0].completed_matches.count).to eq 1
    end
  end
end