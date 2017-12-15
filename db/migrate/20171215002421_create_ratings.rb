class CreateRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :ratings do |t|
      t.integer :section_id
      t.integer :quarter_id
      t.integer :year
      t.string :section_number
      t.integer :responses
      t.integer :enrollment
      t.float :avg_hours
      t.float :comms_mean
      t.float :engaging_mean
      t.float :practical_mean
      t.float :amt_learned_mean
      t.float :recommend_mean
      t.integer :comms_median
      t.integer :engaging_median
      t.integer :practical_median
      t.integer :amt_learned_median
      t.integer :recommend_median

      t.timestamps
    end
  end
end
