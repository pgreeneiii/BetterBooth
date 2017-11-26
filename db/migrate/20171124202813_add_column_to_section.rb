class AddColumnToSection < ActiveRecord::Migration[5.0]
  def change
    add_column :sections, :content, :text
  end
end
