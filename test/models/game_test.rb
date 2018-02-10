require 'test_helper'

class GameTest < ActiveSupport::TestCase
  def test_max_hand_size
    g = Game.new(size: 4)
    assert_equal(12, g.max_hand_size)

    g2 = Game.new(size: 8)
    assert_equal(6, g2.max_hand_size)
  end

  def test_total_hands
    g = Game.new(size: 3)
    assert_equal(32, g.total_hands)

    g2 = Game.new(size: 7)
    assert_equal(12, g2.total_hands)
  end

  def test_current_player
    g = Game.create(size: 3)
  end

  def test_current_hand
    g = Game.create(size: 3)
    p1 = Player.new
    p2 = Player.new
    p3 = Player.new

    gp1 = g.game_players.create(player: p1)
    gp2 = g.game_players.create(player: p2)
    gp3 = g.game_players.create(player: p3)

    h = Hand.where(position: 0, game: g).first
    assert_equal(h, g.current_hand)

    h.hand_players.create(game_player: gp1, position: 0)

    # `h` should be the current hand until
    # all three players have a `hand_player`
    # for `h`
    assert_equal(h, g.current_hand)

    h.hand_players.create(game_player: gp2, position: 1)
    h.hand_players.create(game_player: gp3, position: 2)
    h2 = Hand.where(position: 1, game: g).first

    assert_equal(h2, g.current_hand)
  end
end
