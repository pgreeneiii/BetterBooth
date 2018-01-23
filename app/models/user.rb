class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

   has_many(:plans, :class_name => "Plan", :foreign_key => "user_id")
   has_many(:schedules, :through => :plans)

   validates_format_of :email, with: /\@chicagobooth\.edu/, message: 'You should have an email from chicagobooth.edu'


end
