require_relative 'card_deck'
require_relative 'go_fish'

class PlayingCard
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    return 11 if rank == "Jack"
    return 12 if rank == "Queen"
    return 13 if rank == "King"
    return 14 if rank == "Ace"
    rank.to_i
  end

  def image_name
    rank == "10" ? "#{rank}#{suit[0]}" : "#{rank[0]}#{suit[0]}"
  end

  def to_s
    "/images/card_faces/#{image_name}"
  end

  def alt_to_s
    "#{rank} of #{suit}"
  end
end