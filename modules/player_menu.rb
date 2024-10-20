module PlayerMenu
  def player_menu
    puts "Ваши карты: #{@player.cards}, сумма ваших очков: #{@player.points_amount} "

    puts
    puts 'Ваши действия: 1 - пропустить ход, 2 - взять карту, 3 - открыть карты'

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

      @player.take_card(@deck)
    when 3
      @round_finish = true
    end
  end
end
