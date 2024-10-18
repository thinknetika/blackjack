class Game
  attr_accessor :player, :dealer, :deck, :current_user

  class << self
    def create_game(name)
      user_name = name
      deck = Deck.create_deck
      player = Player.create_player(user_name: user_name, deck: deck)
      dealer = Player.create_player(user_name: 'Dealer', deck: deck)

      new(player: player, dealer: dealer, deck: deck)
    end
  end

  def initialize(args)
    @player = args[:player]
    @dealer = args[:dealer]
    @deck = args[:deck]
    @current_user = @player
  end

  def start
    puts "Ваши карты: #{@player.cards}, сумма ваших очков: #{@player.points_amount(@deck)} "

    puts
    puts 'Ваши действия: 1 - '

    p  'Выберите действие:'


  end

  def skip_move
    if @current_user == @player
      @current_user = @dealer
    else
      @current_user = @player
    end
  end

  def open_cards; end

  def cards_count
    @current_user.cards.count
  end
end
