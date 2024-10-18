class Player
  # include Logic

  attr_accessor :name, :cards, :cash

  class << self

    def create_player(attrs)
      user_name = attrs[:name]
      deck = attrs[:deck]
      cards = deck.take_cards(2)

      new(name: user_name, cards: cards)
    end
  end

  def initialize(attrs)
    @name = attrs[:name]
    @cards = attrs[:cards]
    @cash = 100
  end

  def points_amount(deck)
    deck.count_points(@cards)
  end

  def take_card(deck)
    deck.take_cards(1)
  end
end
