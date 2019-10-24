require_relative '../../app/models/playing_card'

RSpec.describe PlayingCard, type: :model do

  describe '#value' do
    it 'gives a king the rank of 13' do
      king_of_hearts = PlayingCard.new("King", "Hearts")
      expect(king_of_hearts.value).to eq 13
    end

    it 'gives an ace the rank of 14' do
      ace_of_spades = PlayingCard.new("Ace", "Spades")
      expect(ace_of_spades.value).to eq 14
    end
  end

  describe '#image_name' do
    it 'returns the first letter of the rank and suit' do
      ace_of_hearts = PlayingCard.new("Ace", "Hearts")
      expect(ace_of_hearts.image_name).to eq "AH"
    end

    it 'returns the the rank 10 and the first letter of the cards suit' do
      ten_of_hearts = PlayingCard.new("10", "Hearts")
      expect(ten_of_hearts.image_name).to eq "10H"
    end

    it 'returns the rank of 4 and the first letter of the cards suit' do
      four_of_diamonds = PlayingCard.new("4", "Diamonds")
      expect(four_of_diamonds.image_name).to eq "4D"
    end
  end

  describe '#to_s' do
    it 'returns a string for a given rank and suit' do
      king_of_hearts = PlayingCard.new("King", "Hearts")
      expect(king_of_hearts.to_s).to eq "/images/card_faces/KH"
    end
  end

  describe '#alt_to_s' do
    it 'returns a string for a given rank and suit' do
      queen_of_hearts = PlayingCard.new("Queen", "Hearts")
      expect(queen_of_hearts.alt_to_s).to eq "Queen of Hearts"
    end
  end

  describe '#==' do
    let(:king_of_hearts) {PlayingCard.new("King", "Hearts")}
    let(:ten_of_diamonds) {PlayingCard.new("10", "Diamonds")}

    it 'expects the values be equal' do
      expect(king_of_hearts.rank == king_of_hearts.rank).to be true
    end

    it 'expects the values to not be equal' do
      expect(king_of_hearts.rank == ten_of_diamonds.rank).to be false
    end
  end
end