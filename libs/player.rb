# frozen_string_literal: true

require_relative '../modules/logic'

class Player
  include Logic

  attr_accessor :name, :cards, :cash

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
  end

  def points_amount(deck)
    deck.count_points(@cards)
  end

  def take_card(deck)
    @cards.concat(deck.take_cards(1))
  end
end
