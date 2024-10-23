# frozen_string_literal: true

class Player
  attr_accessor :name, :cards, :bank, :points

  def initialize(name)
    @name = name
    @cards = []
    @bank = 100
    @points = 0
    @open_cards = false
  end

  def points_amount
    count_points
  end

  def count_points
    @points = cards.sum { |card| Deck::RANK_VALUE[card[:rank]] }

    @points -= 10 if include_ace? && points > 21

    @points
  end

  def take_cards(deck, count)
    @cards.concat(deck.take_cards(count))
  end

  def drop_cards(deck)
    @cards.clear
    @cards = deck.take_cards(2)
  end

  def self.after_action(callback_method, *method_names)
    method_names.each do |method_name|
      original_method = instance_method(method_name)

      define_method(method_name) do |*args, &block|
        original_method.bind(self).call(*args, &block)
        send(callback_method)
      end
    end
  end

  def drop
    @cards = []
    @bank = 100
    @points = 0
    @open_cards = false
  end

  def open_cards?
    @open_cards
  end

  after_action :count_points, :take_cards

  private

  def include_ace?
    @cards.any? { |card| card[:rank] == Deck::RANK_VALUE_EXCEPTION }
  end
end
