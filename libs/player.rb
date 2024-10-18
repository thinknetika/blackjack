class Player
  include Logic

  attr_accessor :name, :cards, :cash

  class << self
    def take_cards(deck)
      deck.take_cards
    end

    def create_player(*attrs)
      user_name = attrs[name]
      deck = attrs[deck]
      cards = take_cards(deck)

      new(name: user_name, cards: cards)
    end
  end

  def initialize(*attrs)
    @name = attrs[name]
    @cards = attrs[cards]
    @cash = 100
  end

  def points_amount(deck)
    deck.count_points(cards)
  end

  def take_card(deck)
    deck.take_card
  end
end
