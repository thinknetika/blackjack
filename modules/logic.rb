# frozen_string_literal: true

module Logic
  DEALER_MAX_RATE = 18

  def decision(deck)
    cards_point = points_amount(deck)
    if cards_point < DEALER_MAX_RATE
      puts 'Дилер пропустил ход'
    else
      take_card(deck)
      puts 'Дилер взял ход'
    end
  end
end
