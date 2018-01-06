class WelcomeController < ApplicationController
   skip_before_filter :authenticate_user!

   def welcome
      render ('welcome/welcome.html.erb')
   end
end
