# frozen_string_literal: true

module UserMenu
  def menu(deck)
    puts "Ваши карты: #{cards}, сумма ваших очков: #{points_amount} "

    puts
    take = cards.count < 3 ? '2 - взять карту, ' : ''
    puts "Ваши действия: 1 - пропустить ход, #{take}3 - открыть карты"

    p 'Выберите действие:'
    begin
      choice = Integer(gets)
      check_choice(choice)
    rescue ArgumentError
      puts 'Выберите из предложенных вариантов'
      retry
    end

    case choice
    when 2
      return puts 'У вас максимальное количество карт' if cards.count == 3

      take_cards(deck, 1)
    when 3
      @open_cards = true
    end
  end

  def check_choice(choice)
    raise ArgumentError unless (1..3).include?(choice)
  end
end
