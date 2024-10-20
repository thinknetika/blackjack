# frozen_string_literal: true

require_relative '../modules/player_menu'

class Game
  include PlayerMenu

  attr_accessor :player, :dealer, :deck, :current_gamer
  attr_writer :round_finish

  class << self
    def create_game(name)
      name = name
      deck = Deck.create_deck
      player = Player.create_player(name:, deck:)
      dealer = Player.create_player(name: 'Dealer', deck:)

      new(player:, dealer:, deck:)
    end
  end

  def initialize(args)
    @player = args[:player]
    @dealer = args[:dealer]
    @deck = args[:deck]
    @current_gamer = @player
    @finish_round = false
  end

  def start
    loop do
      if @current_gamer == @player
        player_menu
      else
        @dealer.decision(@deck)
      end

      if cards_count? || overkill? || round_finish?
        finish_round
        next
      end
      change_player
    end
  end

  def cards_count?
    @player.cards.count == 3 && @dealer.cards.count == 3
  end

  private

  #alias_method :next_player, :change_player

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

  def finish_round
    open_cards

    player_points = @player.count_points
    dealer_points = @dealer.count_points

    puts "Ваши очки: #{player_points}"
    puts "Очки дилера: #{dealer_points}"

    if overkill?
      change_player
      winner(@current_gamer)
    end

    if player_points > dealer_points
      winner(@player)
        elsif player_points == dealer_points
      puts 'tie'
    else
      winner(@dealer)
    end

    next_round
  end

  def overkill?
    @current_gamer.count_points > 21
  end


  def open_cards
    puts @player.cards
    puts @dealer.cards
  end

  def winner(player)
    puts "#{player.name} win"
  end

  def next_round
    @player.drop_cards(@deck)
    @dealer.drop_cards((@deck))
    puts 'Новый раунд'
    @current_gamer = @player
    @round_finish = false
  end

  def round_finish?
    @round_finish
  end
end
