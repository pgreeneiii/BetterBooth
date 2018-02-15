class MailtestingController < ApplicationController
   before_filter :authorize_admin

   def test_plan
      @plans = current_user.plans
      render("mail_testing/plan_email.html.erb", layout: false)
   end
end
