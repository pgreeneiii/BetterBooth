class AddColumnsToEvaluations < ActiveRecord::Migration[5.0]
  def change
    add_column :evaluations, :p1_bid_min, :integer
    add_column :evaluations, :p1_bid_max, :integer
    add_column :evaluations, :p2_bid_min, :integer
    add_column :evaluations, :p2_bid_max, :integer
    add_column :evaluations, :p3_bid_min, :integer
    add_column :evaluations, :p3_bid_max, :integer
    add_column :evaluations, :p4_bid_min, :integer
    add_column :evaluations, :p4_bid_max, :integer
  end
end
