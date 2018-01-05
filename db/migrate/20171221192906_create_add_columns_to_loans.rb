class CreateAddColumnsToLoans < ActiveRecord::Migration[5.0]
  def change
    add_column :loans, :term, :integer
    add_column :loans, :orig_principal, :float
  end
end
