class Bid < ApplicationRecord
   belongs_to(:section, :class_name => "Section", :foreign_key => "section_id")
   belongs_to(:timetable, :class_name => "TimeTable", :foreign_key => "time_id")
   belongs_to(:daytable, :class_name => "DayTable", :foreign_key => "day_id")
   belongs_to(:quartertable, :class_name => "QuarterTable", :foreign_key => "quarter_id")
end
