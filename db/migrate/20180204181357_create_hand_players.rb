class CreateHandPlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :hand_players do |t|
      t.integer :position
      t.integer :bid
      t.integer :tricks
      t.references :hand, foreign_key: true
      t.references :game_player, foreign_key: true

      t.timestamps
    end
  end
end
