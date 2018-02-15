class Schedule < ApplicationRecord
   belongs_to(:section, :class_name => "Section", :foreign_key => "section_id")
   belongs_to(:timetable, :class_name => "TimeTable", :foreign_key => "time")
   belongs_to(:daytable, :class_name => "DayTable", :foreign_key => "day")
   belongs_to(:quartertable, :class_name => "QuarterTable", :foreign_key => "quarter")
   has_many(:plans, :class_name => 'Plan', :foreign_key => 'schedule_id')
   has_many(:users, :through => :plans)
   has_one(:course, :through => :section)
   has_one(:professor, :through => :section)

   def self.query_ready
      left_outer_joins(section: [:course, :professor]).distinct
   end

   def self.q_sched_day(*args)
      arg0 = args[0] || ""
      if arg0.present?
         day = arg0["schedules_day"] || ""
      else
         day = arg0
      end

      if day.present?
         where("day = :day", {day: day})
      else
         all
      end
   end

   def self.q_sched_quarter(*args)
      quarter_id = args[0] || ""

      if quarter_id.present?
         where("quarter = :quarter", {quarter: quarter_id})
      else
         all
      end
   end

   def self.q_course(*args)
      course_id = args[0] || ""

      if course_id.present?
         where("sections.course_id = :course", {course: course_id})
      else
         all
      end
   end

   def self.q_prof_name(*args)
      arg0 = args[0] || ""

      if arg0.present?
         name = arg0["prof_name_cont"] || ""
      else
         name = arg0
      end

      if name.present?
         where("lower(professors.first_name) LIKE lower(:name) OR lower(professors.last_name) LIKE lower(:name)", {name: "%#{name}%"})
      else
         all
      end
   end

end
