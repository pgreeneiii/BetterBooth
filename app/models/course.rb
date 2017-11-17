class Course < ApplicationRecord
   has_many(:sections, :class_name => "Section", :foreign_key => "course_id")
   has_many(:professors, :through => :sections)
   has_many(:schedules, :through => :sections)
end
