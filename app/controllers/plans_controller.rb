class PlansController < ApplicationController

   # Mail function to generate and email plan to current_user
   def mail
      @plans = current_user.plans
      if @plans.empty?
         flash[:alert] = "No plans to generate!"
         redirect_back fallback_location: root_path
      else
         email = UserMailer.plan_email(current_user)
         email.deliver
         flash[:notice] = 'Plan generated and sent!'
         redirect_back fallback_location: root_path
      end
   end

  def index
    @plans = current_user.plans

    render("plans/index.html.erb")
  end

  def show
    @plan = Plan.find(params[:id])

    render("plans/show.html.erb")
  end

  def new
    @plan = Plan.new

    render("plans/new.html.erb")
  end

  # Create function responds to format.js on index page of course
  def create
     @plan = Plan.new

     @plan.user_id = params[:user_id]
     @plan.schedule_id = params[:schedule_id]
     @course_name = Schedule.find(@plan.schedule_id).course.course_name

     if params[:bid].empty?
        @plan.bid = 1
     else
        @plan.bid = params[:bid]
     end

     save_status = @plan.save

     if save_status == true
        respond_to do |format|
            format.html {redirect_to :back, :notice => "Your planned bid was saved!"}
            format.js # directs to /views/plans/create.js.erb
         end
     else
        redirect_to(:back, :alert => "Sorry! There was an issue.")
     end
  end

  def edit
    @plan = Plan.find(params[:id])

    render("plans/edit.html.erb")
  end

  def update
    @plan = Plan.find(params[:id])

    @plan.user_id = params[:user_id]
    @plan.schedule_id = params[:schedule_id]
    @plan.bid = params[:bid]

    save_status = @plan.save

    if save_status == true
      redirect_to("/plans/#{@plan.id}", :notice => "Plan updated successfully.")
    else
      render("plans/edit.html.erb")
    end
  end

  def destroy
    @plan = Plan.find(params[:id])

    @plan.destroy

    if URI(request.referer).path == "/plans/#{@plan.id}"
      redirect_to("/", :notice => "Plan deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Plan deleted.")
    end
  end
end
