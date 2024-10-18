require_relative 'libs/player'
require_relative 'libs/deck'

deck = Deck.create_deck

player = Player.create_player(name: 'vasya', deck: deck)

puts player.points_amount(deck).inspect
