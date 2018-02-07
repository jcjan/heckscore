class AddDealerToHands < ActiveRecord::Migration[5.1]
  def change
    add_column :hands, :dealer_id, :integer
  end
end
