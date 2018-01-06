class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

   has_many(:loans, :class_name => "Loan", :foreign_key => "user_id")

   validates_format_of :email, with: /\@chicagobooth\.edu/, message: 'You should have an email from chicagobooth.edu'
end
