class CreateDayTables < ActiveRecord::Migration[5.0]
  def change
    create_table :day_tables do |t|
      t.string :day_output

      t.timestamps
    end
  end
end
