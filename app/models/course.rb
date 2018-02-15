class Course < ApplicationRecord
   has_many(:sections, :class_name => "Section", :foreign_key => "course_id")
   has_many(:professors, :through => :sections)
   has_many(:schedules, :through => :sections)


   def fetch_schedules(prof, quarter)
      self.sections.find_by(:professor_id => prof).schedules.where(quarter: quarter)
   end

   def fetch_sections(quarter)
      self.sections.joins(:schedules).where('schedules.quarter = ?', quarter).distinct
   end

   def self.query_ready
      left_outer_joins(sections: [:professor, :schedules]).distinct
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
         all
      end
   end

   def self.q_sched_quarter(*args)
      quarter_id = args[0] || ""
      if quarter_id.present?
         where("schedules.quarter = :quarter", {quarter: quarter_id})
      else
         all
      end
   end

   def self.q_course_name(*args)
      arg0 = args[0] || ""
      if arg0.present?
         name = arg0["course_name_cont"] || ""
      else
         name = arg0
      end

      if name.present?
         where("lower(course_name) LIKE lower(:name)", {name: "%#{name}%"})
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

   def self.q_course_subject(*args)
      arg0 = args[0] || ""
      if arg0.present?
         subject = arg0["subject"] || ""
      else
         subject = arg0
      end

      if subject.present?
         where("subject = :subject", {subject: subject})
      else
         all
      end
   end

end
