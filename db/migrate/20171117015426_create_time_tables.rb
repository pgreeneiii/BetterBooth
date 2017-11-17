class CreateTimeTables < ActiveRecord::Migration[5.0]
  def change
    create_table :time_tables do |t|
      t.string :time_output

      t.timestamps
    end
  end
end
