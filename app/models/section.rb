class Section < ApplicationRecord
   has_many(:courses, :class_name => "Course", :foreign_key => "id")
   has_many(:professors, :class_name => "Professor", :foreign_key => "id")
end
