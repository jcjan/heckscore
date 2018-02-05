class Game < ApplicationRecord
  has_many :game_players
  has_many :players, :through => :game_players

  after_create_commit :create_hands

  def max_hand_size
    return 51 / self.size
  end

  def hand_count
    return (self.max_hand_size * 2) - 1
  end

  def create_hands
    for p in 0..self.hand_count
      Hand.create(game: self, position: p)
    end
  end
end
