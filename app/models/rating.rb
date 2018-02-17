class Rating < ApplicationRecord
   belongs_to(:section, :class_name => "Section", :foreign_key => "section_id")
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
end
