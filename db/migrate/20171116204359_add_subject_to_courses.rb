class AddSubjectToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :subject, :string
  end
end
