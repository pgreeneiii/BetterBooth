class CreateBids < ActiveRecord::Migration[5.0]
  def change
    create_table :bids do |t|
      t.integer :section_id
      t.integer :quarter_id
      t.integer :year
      t.integer :day_id
      t.integer :time_id
      t.integer :p1_price
      t.integer :p2_price
      t.integer :p3_price
      t.integer :p4_price
      t.integer :new_student_p1_price
      t.integer :new_student_p2_price

      t.timestamps
    end
  end
end
