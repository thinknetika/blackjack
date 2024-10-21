# frozen_string_literal: true

require_relative '../modules/user_menu'

class Game
  class << self
    def create_game(name)
      deck = Deck.create_deck
      user = User.new(name:)
      dealer = Dealer.new(name: 'Dealer')

      new(user:, dealer:, deck:)
    end
  end

  def initialize(*attrs)
    @round = Round.new(*attrs)
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

      next unless choice.zero?

      puts 'Вы закнчили игру'
      abort
    end
  end
end
