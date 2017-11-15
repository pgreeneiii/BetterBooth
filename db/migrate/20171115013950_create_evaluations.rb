class CreateEvaluations < ActiveRecord::Migration[5.0]
  def change
    create_table :evaluations do |t|
      t.integer :class_id
      t.float :avg_hours
      t.float :communication
      t.float :engagement
      t.float :practical
      t.float :learning
      t.float :recommendation
      t.integer :bid_min
      t.integer :bid_max

      t.timestamps

    end
  end
end
