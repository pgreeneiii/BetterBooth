class Professor < ApplicationRecord
   has_many(:sections, :class_name => "Section", :foreign_key => "professor_id")
   has_many(:courses, :through =>:sections)
   has_many(:schedules, :through => :sections)

   def self.query_ready
      left_outer_joins(sections: [:course, :schedules]).distinct
   end

   def self.q_sched_day(*args)
      arg0 = args[0] || ""
      if arg0.present?
         day = arg0["schedules_day"] || ""
      else
         day = arg0
      end
      if day.present?
         where("schedules.day = :day", {day: day})
      else
         where.not("schedules.day = :day", {day: day})
      end
   end

   def self.q_sched_quarter(*args)
      quarter_id = args[0] || ""
      if quarter_id.present?
         where("schedules.quarter = :quarter", {quarter: quarter_id})
      else
         where.not("schedules.quarter = :quarter", {quarter: quarter_id})
      end
   end

   def self.q_course(*args)
      course_id = args[0] || ""
      if course_id.present?
         where("course_id = :course", {course: course_id})
      else
         where.not("course_id = :course", {course: course_id})
      end
   end

   def self.q_prof_name(*args)
      arg0 = args[0] || ""
      if arg0.present?
         name = arg0["prof_name_cont"] || ""
      else
         name = arg0
      end

      where("first_name LIKE :name OR last_name LIKE :name", {name: "%#{name}%"})
   end

end
