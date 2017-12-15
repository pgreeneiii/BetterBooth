class Rating < ApplicationRecord
   belongs_to(:section, :class_name => "Section", :foreign_key => "section_id")
   belongs_to(:quartertable, :class_name => "QuarterTable", :foreign_key => "quarter_id")
end
