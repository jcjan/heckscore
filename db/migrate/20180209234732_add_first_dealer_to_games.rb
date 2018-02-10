class AddFirstDealerToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :first_dealer_id, :integer
  end
end
