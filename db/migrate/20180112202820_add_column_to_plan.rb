class AddColumnToPlan < ActiveRecord::Migration[5.0]
  def change
    add_column :plans, :bid, :integer
  end
end
