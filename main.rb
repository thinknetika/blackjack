require_relative 'libs/player'
require_relative 'libs/deck'
require_relative 'libs/game'

game = Game.create_game('vasya')

game.start
