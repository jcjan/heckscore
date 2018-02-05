class Hand < ApplicationRecord
  belongs_to :game

  def card_count
    if self.position <= self.game.max_hand_size
      return self.position + 1
    else
      return (self.game.max_hand_size - 1) - (self.position - self.game.max_hand_size)
    end
  end
end
