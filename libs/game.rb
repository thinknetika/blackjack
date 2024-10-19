# frozen_string_literal: true

class Game
  attr_accessor :player, :dealer, :deck, :current_gamer

  class << self
    def create_game(name)
      user_name = name
      deck = Deck.create_deck
      player = Player.create_player(user_name:, deck:)
      dealer = Player.create_player(user_name: 'Dealer', deck:)

      new(player:, dealer:, deck:)
    end
  end

  def initialize(args)
    @player = args[:player]
    @dealer = args[:dealer]
    @deck = args[:deck]
    @current_gamer = @player
  end

  def start
    loop do
      if @current_gamer == @player
        player_menu
      else
        @dealer.decision(@deck)
        change_player
      end

      finish_game if cards_count? || overkill?
    end
  end

  def cards_count?
    @player.cards.count == 3 && @dealer.cards.count == 3
  end

  private

  def player_menu
    puts "Ваши карты: #{@player.cards}, сумма ваших очков: #{@player.points_amount(@deck)} "

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
      finish_game
    end

    change_player
  end

  def change_player
    @current_gamer = if @current_gamer == @player
                       @dealer
                     else
                       @player
                     end
  end

  def check_choice(choice)
    raise ArgumentError unless (1..3).include?(choice)
  end

  def finish_game
    open_cards

    player_points = deck.count_points(@player.cards)
    dealer_points = deck.count_points(@dealer.cards)

    puts "Ваши очки: #{player_points}"
    puts "Очки дилера: #{dealer_points}"

    if player_points > dealer_points && player_points <= 21
      puts 'player win!'
    elsif dealer_points > player_points && @dealer <= 21
      puts 'dealer win'
    else
      puts 'tie'
    end
    abort 'Игра завершена'
  end

  def overkill?
    deck.count_points(@current_gamer.cards) > 21
  end

  def open_cards
    puts @player.cards
    puts @dealer.cards
  end
end
