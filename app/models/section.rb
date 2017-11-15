class Section < ApplicationRecord
   belongs_to(:course, :class_name => "Course", :foreign_key => "course_id")
   belongs_to(:professor, :class_name => "Professor", :foreign_key => "professor_id")
end
