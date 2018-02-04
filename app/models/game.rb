class Game < ApplicationRecord
  has_many :players, through: :game_player
end
