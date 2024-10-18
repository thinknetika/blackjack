class Deck
  CARDS_TYPE = {}.freeze

  attr_accessor :cards

  def count_points(cards); end

  def take_cards(count)
    add_and_remove = proc do |acc, element|
      if acc.length < count
        acc << element
        @cards.delete_at(@cards.index(element))
      end
    end

    result = @cards.inject([], &add_and_remove)

    count == 1 ? result.first : result
  end
end
