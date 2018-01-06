class WelcomeController < ApplicationController
   skip_before_filter :authenticate_user!

   def welcome
      render ('welcome/welcome.html.erb')
   end

   # Acknowledgements
   def ack
      render ('welcome/acknowledgements.html.erb')
   end

   def about
      render ('welcome/about.html.erb')
   end
end
