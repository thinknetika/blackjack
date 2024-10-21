# frozen_string_literal: true

require_relative '../modules/user_menu'

# Класс для представления раунда
class Round
  @@round_count = 0

  attr_reader :user, :dealer, :deck, :winner, :loser

  def initialize(user, dealer, deck)
    @user = user
    @dealer = dealer
    @deck = deck
    @round_finished = false
  end

  def start
    reinitialize_players unless @@round_count > 0
    @user.take_cards(deck, 2)
    @dealer.take_cards(deck, 2)

    while round_finished?
      @user.play
      @dealer.play
    end

    determine_winner
    @@round_count += 1
    return
  end

  private

  def round_finished?
    @user.open_card? || overkill? || round_ended?
  end

  def determine_winner
    @winner = verify_overkill

    @winner ||= if @user.points > @dealer.points
                  @user
                elsif @dealer.points > @user.points
                  @dealer
                else
                  'friendship'
                end

    @loser = @winner == @user ? @dealer : @user

    transfer_bank(@winner, @loser)
  end

  def transfer_bank(winner, loser)
    winner.bank += loser.bank
    loser.bank = 0
  end

  def round_ended?
    @user.cards.count == 3 && @dealer.cards.count == 3
  end

  def overkill?
    @user.count_points > 21 || @dealer.count_points > 21
  end

  def verify_overkill
    if @user.points > 21
      @winner = @dealer
    elsif @dealer.points > 21
      @winner = @user
    end
  end
end
