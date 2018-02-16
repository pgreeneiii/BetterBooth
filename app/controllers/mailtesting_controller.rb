class MailtestingController < ApplicationController
   before_filter :authorize_admin

   def test_plan
      @plans = current_user.plans
      render("mail_testing/plan_email.html.erb", layout: false)
   end

   def test_welcome
      render("mail_testing/welcome_email.html.erb", layout: false)
   end

   def test_confirm
      render("mail_testing/confirmation_email.html.erb", layout: false)
   end
end
