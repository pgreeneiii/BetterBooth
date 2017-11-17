class ChangeClassIdToSectionId < ActiveRecord::Migration[5.0]
  def change
     rename_column :evaluations, :class_id, :section_id
  end
end
