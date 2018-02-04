class HandPlayer < ApplicationRecord
  belongs_to :hand
  belongs_to :game_player
end
