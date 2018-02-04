class AddSizeToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :size, :integer, null: false, default: 4
  end
end
