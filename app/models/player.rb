require_relative 'go_fish'

class Player
  attr_accessor :name, :hand, :completed_matches

  def initialize(name)
    @name = name
    @hand = []
    @completed_matches = []
  end

  def self.from_json(player_hash)
    return nil if player_hash.blank?
    player = Player.new(player_hash["name"])
    player.build_player(player_hash)
  end

  def build_player(player_hash)
    player_hash["hand"].each do |card_hash|
      hand << PlayingCard.new(card_hash["rank"], card_hash["suit"])
    end
    player_hash["completed_matches"].each do |book|
      completed_matches << book
    end
    self
  end

  def add_cards_to_hand(*cards)
    cards.each {|card| hand << card}
  end

  def add_players_cards_to_hand(cards)
    cards.each {|card| hand << card}
  end

  def unique_ranks
    @hand.map(&:rank).uniq
  end

  def has_rank?(rank)
    hand.map(&:rank).include?(rank)
  end

  def count_matches
    if no_cards? == false
      number_of_ranks = Hash.new(0)
      hand.each {|card| number_of_ranks[card.rank] += 1}
      number_of_ranks.each do |rank, cards| 
        if cards == 4
          matches = add_book(rank)
          true
        end
      end
    end
  end

  def no_cards?
    hand.count == 0 ? true : false
  end

  def remove_cards_from_hand(asked_rank)
    rank_arr = hand.select {|card| card.rank == asked_rank}
    hand.delete_if {|card| card.rank == asked_rank}
    rank_arr
  end

  def ==(other)
    name == other&.name && hand == other.hand
  end
  
  private

  def players_rank_number
    number_of_ranks = Hash.new(0)
    hand.each {|card| number_of_ranks[card.rank] += 1}
    number_of_ranks
  end

  def add_book(rank)
    remove_cards_from_hand(rank)
    completed_matches.push(rank)
  end


end