class Course < ApplicationRecord
   has_many(:sections, :class_name => "Section", :foreign_key => "course_id")
   has_many(:professors, :through => :sections)
   has_many(:schedules, :through => :sections)


   def fetch_schedules(prof)
      self.sections.find_by(:professor_id => prof).schedules
   end
end
