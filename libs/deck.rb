class Deck
  RANK_VALUE = {
    '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9, '10' => 10,
    'Jack' => 10, 'Queen' => 10, 'King' => 10, 'Ace' => 11
  }.freeze

  SUITS = %w[Hearts Diamonds Clubs Spades].freeze
  RANKS = %w[2 3 4 5 6 7 8 9 10 Jack Queen King Ace].freeze

  class << self
    def create_deck
      cards = []

      SUITS.each do |suit|
        RANKS.each do |rank|
          cards << { suit: suit, rank: rank }
        end
      end

      new(cards)
    end
  end

  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end

  def count_points(cards)
    cards.sum { |card| RANK_VALUE[card[:rank]] }
  end

  def take_cards(count)
    add_and_remove = proc do |acc, element|
      if acc.length < count
        acc << element
        @cards.delete_at(@cards.index(element))
        acc
      else
        acc
      end
    end

    result = @cards.inject([], &add_and_remove)

    count == 1 ? result.first : result
  end
end
