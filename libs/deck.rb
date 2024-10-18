class Deck
  # CARDS_TYPE = {}.freeze

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

  def count_points(cards); end

  def take_cards(count)
    add_and_remove = proc do |acc, element|
      if acc.length < count
        acc << element
        @cards.delete_at(@cards.index(element))
      end
    end

    result = @cards.inject([], &add_and_remove)

    count == 1 ? result.first : result
  end
end
