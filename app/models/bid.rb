class Bid < ApplicationRecord
   belongs_to(:section, :class_name => "Section", :foreign_key => "section_id")
   belongs_to(:timetable, :class_name => "TimeTable", :foreign_key => "time_id")
   belongs_to(:daytable, :class_name => "DayTable", :foreign_key => "day_id")
   belongs_to(:quartertable, :class_name => "QuarterTable", :foreign_key => "quarter_id")
   has_one(:course, :through => :section)

   def self.fetch_by_subject(*args)
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
         all
      else
         joins(:course).where("courses.subject = :subject", {subject: subject})
      end
   end

   def self.average_bid(*args)
      day = args[0] || ""
      time = args[1] || ""
      phase = args[2] || ""

      if phase.present?
         phase = "p#{phase}_price"
      else
         phase = "p1_price"
      end

      if day.present? && time.present?
         where("day_id = :day AND time_id = :time", {day: day, time: time}).average(phase).to_f.round(2)
      elsif day.present? && time.empty?
         where("day_id = :day", {day: day}).average(phase).to_f.round(2)
      elsif day.empty? && time.present?
         where("time_id = :time", {time: time}).average(phase).to_f.round(2)
      else
         all.average(phase).to_f.round(2)
      end
   end

   def self.average_bid_count(*args)
      day = args[0] || ""
      time = args[1] || ""
      phase = args[2] || ""

      if phase.present?
         phase = "p#{phase}_price"
      else
         phase = "p1_price"
      end

      if day.present? && time.present?
         where("day_id = :day AND time_id = :time", {day: day, time: time}).count
      elsif day.present? && time.empty?
         where("day_id = :day", {day: day}).count
      elsif day.empty? && time.present?
         where("time_id = :time", {time: time}).count
      else
         all.count
      end
   end
end
