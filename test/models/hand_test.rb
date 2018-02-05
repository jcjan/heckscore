require 'test_helper'

class HandTest < ActiveSupport::TestCase
  def test_card_count
    g = Game.new(size: 4)

    h1 = Hand.new(game: g, position: 0)
    assert_equal(1, h1.card_count)

    h2 = Hand.new(game: g, position: 13)
    assert_equal(10, h2.card_count)

    h3 = Hand.new(game: g, position: 22)
    assert_equal(1, h3.card_count)
  end
end
