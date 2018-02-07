class Hand < ApplicationRecord
  belongs_to :game
  belongs_to :dealer, :class_name => "GamePlayer", optional: true
  has_many :hand_players

  default_scope { order(position: :asc) }

  def card_count
    if self.position < self.game.max_hand_size
      return self.position + 1
    else
      return (self.game.max_hand_size + 1) - (self.position - self.game.max_hand_size) - 2
    end
  end
end
