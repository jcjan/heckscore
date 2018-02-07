class HandPlayer < ApplicationRecord
  belongs_to :hand
  belongs_to :game_player

  def got_set
    return self.bid != self.tricks
  end

  def hand_score
    score = self.tricks
    if !self.got_set
      score += 10
    end
    return score
  end

  # the cumulative score up to this point
  def game_score
    previous_hands = self.game_player.hand_players.joins(:hand).where(
      "hands.position <= ?", self.hand.position
    )
    gs = 0
    for h in previous_hands
      gs += h.hand_score
    end
    return gs
  end
end
