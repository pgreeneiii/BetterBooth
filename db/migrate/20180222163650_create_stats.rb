class CreateStats < ActiveRecord::Migration[5.0]
  def change
    create_table :stats do |t|
      t.integer :course_id
      t.integer :quarter
      t.integer :ratings_count
      t.integer :bids_count
      t.float :hours
      t.float :comms
      t.float :engage
      t.float :practical
      t.float :amt_learned
      t.float :recommend
      t.float :enrollment
      t.float :p1
      t.float :p2
      t.float :p3
      t.float :p4

      t.timestamps
    end
  end
end
