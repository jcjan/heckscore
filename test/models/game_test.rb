require 'test_helper'

class GameTest < ActiveSupport::TestCase
  def test_max_hand_size
    g = Game.new(size: 4)
    assert_equal(12, g.max_hand_size)

    g2 = Game.new(size: 8)
    assert_equal(6, g2.max_hand_size)
  end

  def test_hand_count
    g = Game.new(size: 3)
    assert_equal(33, g.hand_count)

    g2 = Game.new(size: 7)
    assert_equal(13, g2.hand_count)
  end
end
