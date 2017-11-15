class Professor < ApplicationRecord
   has_many(:sections, :class_name => "Section", :foreign_key => "professor_id")
   has_many(:courses, :through =>:sections)
end
