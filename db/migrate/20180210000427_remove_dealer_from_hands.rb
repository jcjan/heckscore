class RemoveDealerFromHands < ActiveRecord::Migration[5.1]
  def change
    remove_column :hands, :dealer_id, :string
  end
end
