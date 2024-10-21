# frozen_string_literal: true

require_relative '../modules/player_menu'

class Game
  include PlayerMenu

  attr_accessor :player, :dealer, :deck, :current_player
  attr_writer :round_finished

  class << self
    def create_game(name, cash = 100)
      deck = Deck.create_deck
      player = Player.create_player(name:, deck:, cash:)
      dealer = Player.create_player(name: 'Dealer', deck:, cash:)

      new(player:, dealer:, deck:)
    end
  end

  def initialize(args)
    @player = args[:player]
    @dealer = args[:dealer]
    @deck = args[:deck]
    @current_player = @player
    @round_finished = false
  end

  def start
    loop do
      if @current_player == @player
        player_menu
      else
        @dealer.decision(@deck)
      end

      if round_ended? || overkill? || round_finished?
        finish_round
        next
      end

      change_player
    end
  end

  # Проверяет, завершился ли раунд
  def round_ended?
    @player.cards.count == 3 && @dealer.cards.count == 3
  end

  private

  def change_player
    @current_player = @current_player == @player ? @dealer : @player
  end

  def finish_round
    open_cards

    player_points = @player.count_points
    dealer_points = @dealer.count_points

    puts "Ваши очки: #{player_points}"
    puts "Очки дилера: #{dealer_points}"

    if overkill?
      change_player
      winner(@current_player)
      transfer_cash(@current_player, @player)
    else
      determine_winner(player_points, dealer_points)
    end

    next_round
  end

  # Проверяет, превышает ли счет игрока 21
  def overkill?
    @current_player.count_points > 21
  end

  def open_cards
    puts @player.cards
    puts @dealer.cards
  end

  def winner(player)
    puts "#{player.name} win"
  end

  # Определяет победителя раунда
  def determine_winner(player_points, dealer_points)
    if player_points > dealer_points
      winner(@player)
      transfer_cash(@player, @dealer)
    elsif player_points == dealer_points
      puts 'Ничья'
    else
      winner(@dealer)
      transfer_cash(@dealer, @player)
    end
  end

  # Перевод денег из банка проигравшего в банк победителя
  def transfer_cash(winner, loser)
    winner.cash += loser.cash
    loser.cash = 0
    puts "Банк #{winner.name}: #{winner.cash}"
    puts "Банк #{loser.name}: #{loser.cash}"
  end

  def next_round
    @player.drop_cards(@deck)
    @dealer.drop_cards(@deck)
    puts 'Новый раунд'
    @current_player = @player
    @round_finished = false
  end

  def round_finished?
    @round_finished
  end
end