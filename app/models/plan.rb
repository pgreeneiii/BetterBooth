class Plan < ApplicationRecord
   belongs_to(:user, :class_name => "User", :foreign_key => "user_id")
   belongs_to(:schedule, :class_name => "Schedule", :foreign_key => "schedule_id")
   has_one(:section, :through => :schedule)
end
