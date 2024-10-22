class Card
  attr_reader :s, :r

  def initialize(suit, rank)
    @s = suit
    @r = rank
  end

  SUITS = {
    '♠' => 'Spades',
    '♥' => 'Hearts',
    '♦' => 'Diamonds',
    '♣' => 'Clubs'
  }.freeze

  RANKS = {
    'A' => 'Ace',
    '2' => 'Two',
    '3' => 'Three',
    '4' => 'Four',
    '5' => 'Five',
    '6' => 'Six',
    '7' => 'Seven',
    '8' => 'Eight',
    '9' => 'Nine',
    'T' => 'Ten',
    'J' => 'Jack',
    'Q' => 'Queen',
    'K' => 'King'
  }.freeze

end

class Console
  attr_accessor :maket, :line_1, :line_2, :line_3, :line_4, :line_5, :line_6, :line_7

  def initialize
    @maket = maket
  end

  def draw(cards)
    # line_proc = proc do |cards_1, line|
    #   cards_1.map { |s, r| line }
    # end

    # size = cards.size
    # @cards_pseuvdo = [
    # [@line_1 * size].join,
    # [line_proc.call(@cards, @line_2)]
    # ]
    @maket.map { |elemnet| elemnet.call(cards).join(' ' * 5) }
  end

  private

  def maket = [
    proc { |cards| ['┌──────────┐'] * cards.size },
    proc { |cards|
      cards.map do |card|
        r = card.r
        "│#{r}         │"
      end
    },
    proc { |cards| ['│          │'] * cards.size },
    proc { |cards|
      cards.map do |card|
        s = card.s
        "│    #{s}     │"
      end
    },
    proc { |cards| ['│          │'] * cards.size },
    proc { |cards|
      cards.map do |card|
        r = card.r
        "│         #{r}│"
      end
    },
    proc { |cards| ['└──────────┘'] * cards.size }
  ]
end

# Создаем три карты
cards = [
  Card.new('♠', 'A'),
  Card.new('♥', 'K'),
# Card.new('♦', '7')
]

console = Console.new

puts console.draw(cards)
