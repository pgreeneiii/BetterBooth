class CreateQuarterTables < ActiveRecord::Migration[5.0]
  def change
    create_table :quarter_tables do |t|
      t.string :quarter_output

      t.timestamps
    end
  end
end
