# frozen_string_literal: true

require_relative '../modules/logic'

class Player
  include Logic

  attr_accessor :name, :cards, :cash, :points

  class << self
    def create_player(args)
      user_name = args[:name]
      deck = args[:deck]
      cards = deck.take_cards(2)

      new(name: user_name, cards:)
    end
  end

  def initialize(args)
    @name = args[:name]
    @cards = args[:cards]
    @cash = 100
    @points = count_points
  end

  def points_amount
    count_points
  end

  def take_card(deck)
    @cards.concat(deck.take_cards(1))
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
