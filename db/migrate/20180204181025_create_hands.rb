class CreateHands < ActiveRecord::Migration[5.1]
  def change
    create_table :hands do |t|
      t.integer :position
      t.references :game, foreign_key: true

      t.timestamps
    end
  end
end
