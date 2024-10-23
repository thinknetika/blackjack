class Console
  attr_accessor :layout, :hidden_layout

  def initialize
    @layout = layout
    @hidden_layout = hidden_layout
  end

  def draw(user)
    name = user.name
    cards = user.cards

    puts "Карты игрока #{name}"

    if name == 'Dealer' && user.hidden_card?
      puts @hidden_layout.map { |element| element.call(cards).join(' ' * 5) }
    else
      puts @layout.map { |element| element.call(cards).join(' ' * 5) }

      puts "Сумма очков: #{user.points_amount}"
    end
  end

  def win(winner)
    puts "Победил #{winner.name}"
  end

  private

  def layout = [
    proc { |cards| ['┌──────────┐'] * cards.size },
    proc { |cards|
      cards.map do |card|
        r = card[:rank]
        r == '10' ? "│#{r}        │" : "│#{r}         │"
      end
    },
    proc { |cards| ['│          │'] * cards.size },
    proc { |cards|
      cards.map do |card|
        s = card[:suit]
        "│    #{s}     │"
      end
    },
    proc { |cards| ['│          │'] * cards.size },
    proc { |cards|
      cards.map do |card|
        r = card[:rank]
        r == '10' ? "│        #{r}│" : "│         #{r}│"
      end
    },
    proc { |cards| ['└──────────┘'] * cards.size }
  ]

  def hidden_layout
    [
      proc { |cards| ['┌──────────┐'] * cards.size },
      proc { |cards| ['│          │'] * cards.size },
      proc { |cards| ['│          │'] * cards.size },
      proc { |cards| ['│          │'] * cards.size },
      proc { |cards| ['│          │'] * cards.size },
      proc { |cards| ['│          │'] * cards.size },
      proc { |cards| ['└──────────┘'] * cards.size }
    ]
  end
end
