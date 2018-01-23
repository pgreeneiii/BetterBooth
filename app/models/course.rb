class Course < ApplicationRecord
   has_many(:sections, :class_name => "Section", :foreign_key => "course_id")
   has_many(:professors, :through => :sections)
   has_many(:schedules, :through => :sections)


   def fetch_schedules(prof, quarter)
      self.sections.find_by(:professor_id => prof).schedules.where(quarter: quarter)
   end
end
