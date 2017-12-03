class Bid < ApplicationRecord
   belongs_to(:section, :class_name => "Section", :foreign_key => "section_id")
end
