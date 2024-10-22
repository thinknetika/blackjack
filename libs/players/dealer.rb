# frozen_string_literal: true

class Dealer < Player
  DEALER_MAX_RATE = 18

  def play(deck)
    decision(deck)
  end

  def decision(deck)
    cards_point = points_amount
    if cards_point < DEALER_MAX_RATE
      puts 'Дилер пропустил ход'
    else
      take_cards(deck, 1)
      puts 'Дилер взял ход'
    end
  end
end
