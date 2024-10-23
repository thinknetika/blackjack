# frozen_string_literal: true

require_relative '../modules/user_menu'
require_relative '../libs/round'

class Game
  class << self
    def create_game(name)
      deck = Deck.create_deck
      user = User.new(name)
      dealer = Dealer.new('Dealer')
      console = Console.new
      new(user:, dealer:, deck:, console:)
    end
  end

  def initialize(args)
    @round = Round.new(args)
  end

  def start
    loop do
      @round.start

      puts 'Нажмите любую клавишу, чтобы продолжить или 0, если хотите закончить игру'

      begin
        choice = gets.chomp
      rescue ArgumentError
        puts 'Ввели что то совсем не то'
        retry
      end

      next unless choice == '0'

      puts 'Вы закончили игру'
      abort
    end
  end
end
