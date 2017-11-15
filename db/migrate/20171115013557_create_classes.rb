class CreateClasses < ActiveRecord::Migration[5.0]
  def change
    create_table :classes do |t|
      t.integer :course_id
      t.integer :professor_id

      t.timestamps

    end
  end
end
