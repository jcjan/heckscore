class Game < ApplicationRecord
  has_many :game_players
  has_many :players, :through => :game_players
  has_many :hand_players, :through => :game_players
  has_many :hands

  after_create_commit :create_hands

  def max_hand_size
    return 51 / self.size
  end

  def total_hands
    return (self.max_hand_size * 2) - 2
  end

  def max_player_hand_count
    return self.size * self.total_hands
  end

  def current_hand
    last_hand = self.hand_players.where(position: self.size - 1).last
    if !last_hand
      current_hand = self.hands.first
    else
      current_hand = self.hands.where(position: last_hand.position + 1).first
    end
    return current_hand
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
    for p in 0..self.total_hands
      h = Hand.create(game: self, position: p)
      puts(h.errors.full_messages)
    end
  end
end
