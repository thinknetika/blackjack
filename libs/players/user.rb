# frozen_string_literal: true

require_relative '../../modules/user_menu'

class User < Player
  attr_reader :open_cards

  def initialize(name)
    @open_cards = false
    super
  end

  def play
    player_menu
  end

  def open_card?
    @open_cards
  end
end
