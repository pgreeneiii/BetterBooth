class RemoveBidMinAndBidMaxFromEvaluations < ActiveRecord::Migration[5.0]
  def change
    remove_column :evaluations, :bid_min, :integer
    remove_column :evaluations, :bid_max, :integer
  end
end
