class DayTable < ApplicationRecord
   has_many(:schedules, :class_name => "Schedule", :foreign_key => "day")
   has_many(:sections, :through => :schedules)
   has_many(:courses, :through => :sections)
end
