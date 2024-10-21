module PlayerMenu
  def player_menu
    puts "Ваши карты: #{@player.cards}, сумма ваших очков: #{@player.points_amount} "

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
      return puts 'У вас максимальное количество карт' if @player.cards.count == 3

      @player.take_cards(@deck, 1)
    when 3
      @round_finished = true
    end
  end

  def check_choice(choice)
    raise ArgumentError unless (1..3).include?(choice)
  end
end
