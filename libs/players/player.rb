# frozen_string_literal: true

class Player
  attr_accessor :name, :cards, :bank, :points

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

  after_action :count_points, :take_cards

  private

  def include_ace
    @cards.any? { |card| card[:rank] == 'Ace' }
  end

  def count_points
    @points = cards.sum { |card| Deck::RANK_VALUE[card[:rank]] }

    @points -= 10 if include_ace && points > 21
  end
end
