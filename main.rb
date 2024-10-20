# frozen_string_literal: true

require_relative 'libs/player'
require_relative 'libs/deck'
require_relative 'libs/game'
require_relative 'modules//player_menu'

puts 'Введите свое имя: '

player_name = gets.chomp

game = Game.create_game(player_name)

game.start
