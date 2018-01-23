class UserMailer < ApplicationMailer

   def welcome_email(user)
      @user = user
      mail(to: @user.email, subject: 'Welcome to BetterBooth!')
   end

   def plan_email(user)
      @user = user
      @plans = user.plans
      date = Date.today

      subject = "Your Bid Plan: Generated on #{date.strftime('%m/%d/%y')}"

      mail(to: @user.email, subject: subject)
   end
end
