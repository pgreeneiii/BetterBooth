class AddColumnToDayTable < ActiveRecord::Migration[5.0]
  def change
    add_column :day_tables, :long_output, :string
  end
end
