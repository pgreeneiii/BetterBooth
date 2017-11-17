class Section < ApplicationRecord
   belongs_to(:course, :class_name => "Course", :foreign_key => "course_id")
   belongs_to(:professor, :class_name => "Professor", :foreign_key => "professor_id")
   has_one(:evaluation, :class_name => "Evaluation", :foreign_key => "section_id")
   has_many(:schedules, :class_name => "Schedule", :foreign_key => "section_id")
end
