# frozen_string_literal: true

require_relative '../modules/player_menu'

# Класс для представления раунда
class Round
  attr_reader :player, :dealer, :deck, :winner

  def initialize(player, dealer, deck)
    @player = player
    @dealer = dealer
    @deck = deck
  end

  def start
    # Раздача карт
    player.take_cards(deck, 2)
    dealer.take_cards(deck,2)

    # Ход игрока
    player.play

    # Ход дилера
    dealer.play(deck)

    # Определение победителя
    determine_winner
  end

  private

  def determine_winner
    # ... (логика определения победителя)
    @winner = # ... (определить победителя)
      transfer_bank(@winner, @player) if @winner != @player
  end

  # Перевод денег из банка проигравшего в банк победителя
  def transfer_bank(winner, loser)
    winner.bank += loser.bank
    loser.bank = 0
    puts "Банк #{winner.name}: #{winner.bank}"
    puts "Банк #{loser.name}: #{loser.bank}"
  end
end

