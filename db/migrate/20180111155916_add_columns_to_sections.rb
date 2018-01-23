class AddColumnsToSections < ActiveRecord::Migration[5.0]
  def change
    add_column :sections, :lectures, :boolean
    add_column :sections, :discussions, :boolean
    add_column :sections, :cases, :boolean
    add_column :sections, :group_projects, :boolean
    add_column :sections, :group_presentations, :boolean
    add_column :sections, :ethics, :boolean
    add_column :sections, :graded_homework, :boolean
    add_column :sections, :graded_participation, :boolean
    add_column :sections, :quizzes, :boolean
    add_column :sections, :midterm, :boolean
    add_column :sections, :midterm_optional, :boolean
    add_column :sections, :final_sit, :boolean
    add_column :sections, :final_take, :boolean
    add_column :sections, :canvas, :boolean
    add_column :sections, :sample_exam, :boolean
  end
end
