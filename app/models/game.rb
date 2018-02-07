class Game < ApplicationRecord
  has_many :game_players
  has_many :players, :through => :game_players
  has_many :hand_players, :through => :game_players, :source => :player
  has_many :hands

  after_create_commit :create_hands

  def max_hand_size
    return 51 / self.size
  end

  def hand_count
    return (self.max_hand_size * 2) - 2
  end

  def max_player_hand_count
    return self.size * self.hand_count
  end

  def status
    player_hand_count = self.hand_players.count
    # no hands have been entered
    if player_hand_count == 0
      return "not started"
    # some hands have been entered
    elsif player_hand_count < self.max_player_hand_count
      return "in progress"
    # all hands have been entered
    else
      return "completed"
    end
  end

  def next_position
    c = self.players.count
    if c < self.size
      return self.players.count
    else
      return nil
    end
  end

  def create_hands
    for p in 0..self.hand_count
      Hand.create(game: self, position: p)
    end
  end
end
