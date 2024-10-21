# frozen_string_literal: true

class Player
  attr_accessor :name, :cards, :cash, :points

  def initialize(name)
    @name = name
    @cards = []
    @cash = 100
    @points = 0
  end

  def points_amount
    count_points
  end

  def take_cards(deck, count)
    @cards.concat(deck.take_cards(count))
  end

  def count_points
    points = cards.sum { |card| Deck::RANK_VALUE[card[:rank]] }

    points -= 10 if include_deck && points > 21

    points
  end

  def drop_cards(deck)
    @cards.clear
    @cards = deck.take_cards(2)
  end

  private
  def include_deck
    @cards.any?{ |card| card[:rank] == 'Ace' }
  end
end
