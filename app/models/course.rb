class Course < ApplicationRecord
   has_many(:sections, :class_name => "Section", :foreign_key => "course_id")
   has_one(:stats, class_name: "Stat", foreign_key: "course_id")
   has_many(:professors, :through => :sections)
   has_many(:schedules, :through => :sections)
   has_many(:ratings, :through => :sections)
   has_many(:bids, :through => :sections)

   def self.bids_count(*args)
      arg0 = args[0] || ""
      if arg0.present?
         subject = arg0["subject"] || ""
         day = arg0["day"] || ""
         time = arg0["time"] || ""
         phase = arg0["phase"] || ""

         if subject.class == Fixnum
            subjects = [
               "All",
               "Financial Management",
               "Accounting",
               "Microeconomics",
               "Macro/International Business",
               "Entrepreneurship",
               "Strategic Management",
               "Operations Management",
               "Marketing Management",
               "Managerial and Organizational Behavior",
               "Organizations and Markets",
               "Statistics"
            ]
            subject = subjects[subject]
         end

         if subject == "All" || subject.blank?
            if day.present? && time.present?
               joins(:bids).where("day_id = :day AND time_id = :time", {day: day, time: time}).distinct.count
            elsif day.present? && time.empty?
               joins(:bids).where("day_id = :day", {day: day}).distinct.count
            elsif day.empty? && time.present?
               joins(:bids).where("time_id = :time", {time: time}).distinct.count
            else
               joins(:bids).distinct.count
            end
         else
            if day.present? && time.present?
               joins(:bids).where("subject = :subject", {subject: subject}).where("day_id = :day AND time_id = :time", {day: day, time: time}).distinct.count
            elsif day.present? && time.empty?
               joins(:bids).where("subject = :subject", {subject: subject}).where("day_id = :day", {day: day}).distinct.count
            elsif day.empty? && time.present?
               joins(:bids).where("subject = :subject", {subject: subject}).where("time_id = :time", {time: time}).distinct.count
            else
               joins(:bids).where("subject = :subject", {subject: subject}).distinct.count
            end
         end
      else
         joins(:bids).distinct.count
      end
   end

   def self.ratings_count(*args)
      subject = args[0] || ""

      if subject.class == Fixnum
         subjects = [
            "All",
            "Financial Management",
            "Accounting",
            "Microeconomics",
            "Macro/International Business",
            "Entrepreneurship",
            "Strategic Management",
            "Operations Management",
            "Marketing Management",
            "Managerial and Organizational Behavior",
            "Organizations and Markets",
            "Statistics"
         ]
         subject = subjects[subject]
      end
      if subject == "All" || subject.blank?
         Course.joins(:ratings).distinct.count
      else
         Course.where("subject = :subject", {subject: subject}).joins(:ratings).distinct.count
      end
   end

   def fetch_schedules(prof, quarter)
      self.sections.find_by(:professor_id => prof).schedules.where(quarter: quarter)
   end

   def fetch_sections(quarter)
      self.sections.joins(:schedules).where('schedules.quarter = ?', quarter).distinct
   end

   def self.query_ready
      left_outer_joins(sections: [:professor, :schedules]).distinct
   end

   def self.q_half(*args)
      arg0 = args[0] || ""
      if arg0.present?
         half = arg0["half"] || ""
      else
         half = arg0
      end

      if half.present?
         where("schedules.half_credit = :half", {half: half})
      else
         all
      end
   end

   def self.q_take_home(*args)
      arg0 = args[0] || ""
      if arg0.present?
         take = arg0["take"] || ""
      else
         take = arg0
      end
      if take.present?
         where("sections.final_take = :take", {take: take})
      else
         all
      end
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
         name = name.chomp(" ")
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
         name = name.chomp(" ")
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

   def half_credit?
      check = false
      if self.schedules.pluck(:half_credit).present?
         self.schedules.pluck(:half_credit).each do |half|
            if half == true
               check = true
            end
         end
      end
      return check
   end

end
