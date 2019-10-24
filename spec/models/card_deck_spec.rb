require_relative '../../app/models/card_deck'

RSpec.describe CardDeck, type: :model do
  describe '#shuffle' do
    it 'shuffles the deck' do
      card_deck1 = CardDeck.new
      card_deck2 = CardDeck.new
      card_deck1.shuffle
      expect(card_deck1).to_not eq(card_deck2)
    end
  end

  describe '#deal' do
    it 'deals a single card to a player' do
      deck = CardDeck.new
      player = Player.new("James")
      player.hand << deck.deal
      expect(player.hand.count).to eq 1
      expect(deck.card_deck.count).to eq 51
    end
  end

  describe '#provide_deck' do
    it 'stocks the deck with cards' do
      deck = CardDeck.new
      expect(deck.card_deck.count).to eq 52 
    end
  end

  describe '#cards_left' do
    let(:king_of_hearts) {PlayingCard.new("King", "Hearts")}
    let(:ten_of_diamonds) {PlayingCard.new("10", "Diamonds")}
    let(:king_of_spades) {PlayingCard.new("King", "Spades")}
    let(:ten_of_clubs) {PlayingCard.new("10", "Clubs")}
    let(:seven_of_hearts) {PlayingCard.new("7", "Hearts")}

    def subtract_cards_from_deck(deck, card_number)
      card_number.times do
        lost_cards = deck.deal
      end
    end

    it 'returns 5 because there are 5 cards left in the deck' do
      deck = CardDeck.new
      subtract_cards_from_deck(deck, 47)
      expect(deck.cards_left).to eq 5
    end


    it 'returns 0 because there are 5 cards left in the deck' do
      deck = CardDeck.new
      subtract_cards_from_deck(deck, 52)
      expect(deck.cards_left).to eq 0
    end
  end

  describe '#==' do
    let(:king_of_hearts) {PlayingCard.new("King", "Hearts")}
    let(:ten_of_diamonds) {PlayingCard.new("10", "Diamonds")}
    let(:deck1) {[ten_of_diamonds, king_of_hearts]}
    let(:deck2) {[ten_of_diamonds, king_of_hearts]}
    let(:deck3) {[king_of_hearts]}

    it 'expects the values be equal' do
      expect(deck1 == deck2).to be true
    end

    it 'expects the values to not be equal' do
      expect(deck1 == deck3).to be false
    end
  end
end