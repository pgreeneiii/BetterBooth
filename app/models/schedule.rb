class Schedule < ApplicationRecord
   belongs_to(:section, :class_name => "Section", :foreign_key => "section_id")
   belongs_to(:timetable, :class_name => "TimeTable", :foreign_key => "time")
   belongs_to(:daytable, :class_name => "DayTable", :foreign_key => "day")
   has_one(:course, :through => :section)
   has_one(:professor, :through => :section)

end
