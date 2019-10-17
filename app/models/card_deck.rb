require_relative 'go_fish'
require_relative 'player'
require_relative 'playing_card'


class CardDeck
  attr_reader :rank, :suit
  attr_accessor :card_deck

  def initialize
    @card_deck = []
    provide_deck
  end

  def shuffle
    self.card_deck = card_deck.shuffle
  end

  def deal
    card_deck.pop
  end

  def provide_deck
    rank.each do |rank|
      suit.each do |suit|
        card_deck << PlayingCard.new("#{rank}", "#{suit}")
        card_deck.each {|card| card.value}
      end
    end
  end

  def rank
    rank = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace)
  end

  def suit
    suit = %w(Spades Hearts Diamonds Clubs)
  end

  def cards_left
    card_deck.count
  end
end