class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.integer :section_id
      t.string :section_number
      t.integer :quarter
      t.integer :day
      t.integer :time
      t.boolean :half_credit

      t.timestamps

    end
  end
end
