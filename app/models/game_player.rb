class GamePlayer < ApplicationRecord
  belongs_to :player
  belongs_to :game
  has_many :hand_players

  default_scope { order(position: :asc) }

  after_create_commit :create_hand_players

  def create_hand_players
    for hand in self.game.hands
      hp = HandPlayer.create(game_player: self, hand: hand)
      puts(hp.errors.full_messages)
    end
  end
end
