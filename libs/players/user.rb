# frozen_string_literal: true

require_relative '../../modules/user_menu'

class User < Player
  include UserMenu

  def play(deck)
    menu(deck)
  end
end
