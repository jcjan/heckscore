class Hand < ApplicationRecord
  belongs_to :game
  has_many :hand_players

  default_scope { order(position: :asc) }

  # Returns the `GamePlayer` who dealt this hand.
  # The dealer moves one position to the left
  # with each new hand.
  def dealer
    first_dealer = self.game.first_dealer
    if not first_dealer
      return nil
    end
    first_dealer_position = self.game.first_dealer.position
    p = self.position + first_dealer_position
    while p > self.game.size - 1
      p = p - self.game.size
    end
    return self.game.game_players.where(position: p).first
  end

  def card_count
    if self.position < self.game.max_hand_size
      return self.position + 1
    else
      return (self.game.max_hand_size + 1) - (self.position - self.game.max_hand_size) - 2
    end
  end
end
