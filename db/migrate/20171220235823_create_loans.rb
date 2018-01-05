class CreateLoans < ActiveRecord::Migration[5.0]
  def change
    create_table :loans do |t|
      t.string :name
      t.float :principal
      t.date :due_date
      t.float :apr
      t.integer :user_id

      t.timestamps

    end
  end
end
