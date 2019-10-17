require_relative 'go_fish'
require_relative 'player'
require_relative 'card_deck'

RSpec.describe GoFish, type: :model do
  let(:moses) {Player.new("Moses")}

  let(:five_of_hearts) {PlayingCard.new("5", "Hearts")}
  let(:five_of_spades) {PlayingCard.new("5", "Spades")}
  let(:five_of_clubs) {PlayingCard.new("5", "Clubs")}
  let(:five_of_diamonds) {PlayingCard.new("5", "Diamonds")}
  let(:eight_of_diamonds) {PlayingCard.new("8", "Diamonds")}
  let(:four_of_hearts) {PlayingCard.new("4", "Hearts")}
  let(:four_of_spades) {PlayingCard.new("4", "Spades")}
  let(:jack_of_spades) {PlayingCard.new("Jack", "Spades")}
  let(:jack_of_clubs) {PlayingCard.new("Jack", "Clubs")}
  let(:queen_of_clubs) {PlayingCard.new("Queen", "Clubs")}
  let(:queen_of_diamonds) {PlayingCard.new("Queen", "Diamonds")}

  def create_and_start_game_with_two_cpus
    @game2 = GoFish.new
    @game2.add_player(moses)
    @game2.create_cpu(2)
  end
  
  def create_and_start_game_with_one_cpu
    @game1 = GoFish.new
    @game1.add_player(moses)
    @game1.create_cpu(1)
  end

  describe '#create_cpu' do
    it 'creates a player and two cpu and adds them to the players array' do
      create_and_start_game_with_two_cpus
      expect(@game2.players.count).to eq 3
    end
  end

  describe '#add_player' do
    it 'adds a player to the players array' do
      create_and_start_game_with_one_cpu
      expect(@game1.players.count).to eq 2
      expect(@game1.players[0].name).to eq "Moses"
    end
  end

  describe '#empty?' do
    it 'returns true because the players array is empty' do
      game = GoFish.new
      expect(game.empty?).to eq true
    end

    it 'returns false because the players array contains players' do
      create_and_start_game_with_one_cpu
      expect(@game1.empty?).to eq false
    end
  end

  describe '#find_current_player' do
    it 'expects player 1 to be the current player' do
      create_and_start_game_with_one_cpu
      expect(@game1.find_current_player("Moses")).to eq @game1.players[0]
    end
  end

  describe '#deal' do
    it 'deals the deck' do
      create_and_start_game_with_one_cpu
      expect(@game1.players[0].hand.count).to eq 7
    end
  end

  describe '#deal_count' do
    it 'deals 7 cards if there are two players' do
      create_and_start_game_with_one_cpu
      expect(@game1.deal_count).to eq 7
    end

    it "deals 5 cards if there are more then two players" do
      create_and_start_game_with_two_cpus
      expect(@game2.deal_count).to eq 5
    end
  end

  describe '#start' do
    it 'expects the game to have started' do
      create_and_start_game_with_one_cpu
      expect(@game1.started).to eq true
    end

    it 'expects that the game hasn\'t started' do
      game = GoFish.new
      expect(game.started).to eq false
    end
  end

  describe '#cpu_take_turn' do
    it 'has the bot take a turn' do
      create_and_start_game_with_one_cpu
      @game1.players[0].hand = [four_of_hearts, eight_of_diamonds]
      @game1.players[1].hand = [four_of_spades]
      @game1.take_turn(@game1.players[1], @game1.players[0], four_of_spades.rank)
      expect(@game1.players[0].hand.count).to eq 1
      expect(@game1.players[1].hand.count).to eq 2
    end
  end

  describe '#take_turn' do
    context 'other player has the rank asked for' do
      it 'gives the player the card from the other player' do
        create_and_start_game_with_one_cpu
        @game1.card_deck.card_deck = [jack_of_spades, queen_of_clubs]
        @game1.players[0].hand = [five_of_clubs, eight_of_diamonds]
        @game1.players[1].hand = [five_of_diamonds, eight_of_diamonds]
        @game1.take_turn(@game1.players[0], @game1.players[1], five_of_clubs.rank)
        expect(@game1.players[0].hand).to include(five_of_diamonds)
      end

      it 'keeps the asking player as the current player go again' do
        create_and_start_game_with_one_cpu
        @game1.card_deck.card_deck = [jack_of_spades, queen_of_clubs]
        @game1.players[0].hand = [five_of_clubs, eight_of_diamonds]
        @game1.players[1].hand = [five_of_diamonds, eight_of_diamonds]
        @game1.take_turn(@game1.players[0], @game1.players[1], five_of_clubs.rank)
        expect(@game1.current_player).to eq @game1.players[0]
      end
    end

    context 'other player doesn\'t have the rank asked for' do
      it 'lets the player go fish because the other player doesn\'t have any cards' do
        create_and_start_game_with_one_cpu
        @game1.players[0].hand = [five_of_clubs, five_of_spades]
        @game1.players[1].hand = []
        @game1.card_deck.card_deck = [four_of_hearts, five_of_hearts]
        @game1.take_turn(@game1.players[0], @game1.players[1], five_of_clubs.rank)
        expect(@game1.players[0].hand).to include(five_of_hearts)
      end

      context 'player goes fishing' do
        context 'receive from the deck what they asked for' do
          it 'gives the player a new card from the deck that is the rank they asked for' do
            create_and_start_game_with_one_cpu
            @game1.players[0].hand = [five_of_clubs, five_of_spades]
            @game1.players[1].hand = [four_of_spades, eight_of_diamonds]
            @game1.card_deck.card_deck = [four_of_hearts, five_of_hearts]
            @game1.take_turn(@game1.players[0], @game1.players[1], five_of_clubs.rank)
            expect(@game1.players[0].hand).to include(five_of_hearts)
          end
  
          it 'lets the current player go again' do
            create_and_start_game_with_one_cpu
            @game1.players[0].hand = [five_of_clubs, four_of_spades]
            @game1.players[1].hand = [five_of_spades, eight_of_diamonds]
            @game1.card_deck.card_deck = [four_of_hearts, five_of_hearts]
            @game1.take_turn(@game1.players[0], @game1.players[1], five_of_clubs.rank)
            expect(@game1.current_player).to eq @game1.players[0]
          end  
        end

        context 'don\'t receive that they ask from from the deck' do

          it 'gives player a new card from the deck that isn\'t the rank they asked for' do
            create_and_start_game_with_one_cpu
            @game1.players[0].hand = [five_of_clubs, four_of_spades]
            @game1.players[1].hand = [five_of_spades, eight_of_diamonds]
            @game1.card_deck.card_deck = [five_of_hearts, four_of_hearts]
            @game1.take_turn(@game1.players[0], @game1.players[1], four_of_spades.rank)
            expect(@game1.players[0].hand).to include(four_of_hearts)
          end

          it 'advance the player' do
            create_and_start_game_with_one_cpu
            @game1.players[0].hand = [five_of_clubs, four_of_spades]
            @game1.players[1].hand = [five_of_spades, eight_of_diamonds]
            @game1.card_deck.card_deck = [jack_of_clubs, queen_of_clubs]
            @game1.take_turn(@game1.players[0], @game1.players[1], four_of_spades.rank)
            expect(@game1.current_player.name).to eq "CPU1"
          end 
        end

        context 'no more cards in the deck' do

          it 'doesn\'t give the player any cards because the deck doesn\'t contain any cards' do
            create_and_start_game_with_one_cpu
            @game1.players[0].hand = [five_of_clubs, four_of_spades]
            @game1.players[1].hand = [jack_of_clubs, eight_of_diamonds]
            @game1.card_deck.card_deck = []
            @game1.take_turn(@game1.players[0], @game1.players[1], four_of_spades.rank)
            expect(@game1.players[0].hand.count).to eq 2
          end

          it 'advances to the next player' do
            create_and_start_game_with_one_cpu
            @game1.players[0].hand = [five_of_clubs, four_of_spades]
            @game1.players[1].hand = [five_of_spades, eight_of_diamonds]
            @game1.card_deck.card_deck = []
            @game1.take_turn(@game1.players[0], @game1.players[1], four_of_spades.rank)
            expect(@game1.current_player.name).to eq "CPU1"
          end
        end
      end
    end

    context 'made a match and now has no cards' do
      it 'the player has one match in their completed matches' do
        create_and_start_game_with_one_cpu
        @game1.players[0].hand = [five_of_clubs, five_of_diamonds, five_of_hearts]
        @game1.players[1].hand = [five_of_spades, four_of_hearts]
        @game1.card_deck.card_deck = [eight_of_diamonds, four_of_spades, jack_of_spades, jack_of_clubs, queen_of_clubs, queen_of_diamonds]
        @game1.take_turn(@game1.players[0], @game1.players[1], five_of_spades.rank)
        expect(@game1.players[0].completed_matches.count).to eq 1
      end

      it 'the card deck has more then five cards left, so the player draws five cards' do
        create_and_start_game_with_one_cpu
        @game1.players[0].hand = [five_of_clubs, five_of_diamonds, five_of_hearts]
        @game1.players[1].hand = [five_of_spades, four_of_hearts]
        @game1.card_deck.card_deck = [eight_of_diamonds, four_of_spades, jack_of_spades, jack_of_clubs, queen_of_clubs, queen_of_diamonds]
        @game1.take_turn(@game1.players[0], @game1.players[1], five_of_spades.rank)
        expect(@game1.card_deck.card_deck.count).to eq 1
        expect(@game1.players[0].hand.count).to eq 5
      end

      it 'the card deck has cards, but not five, so the player draws all the cards left' do
        create_and_start_game_with_one_cpu
        @game1.players[0].hand = [five_of_clubs, five_of_diamonds, five_of_hearts]
        @game1.players[1].hand = [five_of_spades, four_of_hearts]
        @game1.card_deck.card_deck = [eight_of_diamonds, four_of_spades, jack_of_spades]
        @game1.take_turn(@game1.players[0], @game1.players[1], five_of_spades.rank)
        expect(@game1.players[0].hand.count).to eq 3
      end

      it 'the card deck has no cards left, so the player has 0 cards' do
        create_and_start_game_with_one_cpu
        @game1.players[0].hand = [five_of_clubs, five_of_diamonds, five_of_hearts]
        @game1.players[1].hand = [five_of_spades, four_of_hearts]
        @game1.card_deck.card_deck = []
        @game1.take_turn(@game1.players[0], @game1.players[1], five_of_spades.rank)
        expect(@game1.players[0].completed_matches.count).to eq 1
        expect(@game1.players[0].hand.count).to eq 0
      end

      it 'player has a match and match_num is increased to 13 because the game is over' do
        create_and_start_game_with_one_cpu
        @game1.players[0].hand = [five_of_clubs, five_of_diamonds, five_of_hearts]
        @game1.players[1].hand = [five_of_spades]
        @game1.card_deck.card_deck = []
        @game1.take_turn(@game1.players[0], @game1.players[1], five_of_clubs.rank)
        expect(@game1.players[0].completed_matches.count).to eq 1
        expect(@game1.match_num).to eq 13
      end

      it 'the card deck has no cards left, so the current player is advanced' do
        create_and_start_game_with_one_cpu
        @game1.players[0].hand = [five_of_clubs, five_of_diamonds, five_of_hearts]
        @game1.players[1].hand = [five_of_spades, four_of_hearts]
        @game1.card_deck.card_deck = []
        @game1.take_turn(@game1.players[0], @game1.players[1], five_of_spades.rank)
        expect(@game1.current_player.name).to eq "CPU1"
      end
    end
  end

  describe '#bot?' do
    it 'returns true if the player is a bot' do
      create_and_start_game_with_one_cpu
      expect(@game1.players[1].bot?).to eq true
    end

    it 'returns false if the player is not a bot' do
      create_and_start_game_with_one_cpu
      expect(@game1.players[0].bot?).to eq false
    end
  end
end