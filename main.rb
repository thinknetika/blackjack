# frozen_string_literal: true

require_relative 'libs/player'
require_relative 'libs/deck'
require_relative 'libs/game'

puts 'Введите свое имя: '

player_name = gets.chomp

game = Game.create_game(player_name)

game.start
