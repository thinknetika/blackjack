# frozen_string_literal: true

class Deck
  RANK_VALUE = {
    '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9, '10' => 10,
    'J' => 10, 'Q' => 10, 'K' => 10, 'A' => 11
  }.freeze

  SUITS = %w[♥ ♦ ♣ ♠].freeze
  RANKS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze

  class << self
    def create_deck
      cards = []

      SUITS.each do |suit|
        RANKS.each do |rank|
          cards << { suit:, rank: }
        end
      end

      new(cards)
    end
  end

  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end

  def take_cards(count)
    result = @cards.sample(count)

    remove_elements(result)

    result
  end

  private

  def remove_elements(elements)
    elements.each { |element| @cards.delete(element) }
  end
end
