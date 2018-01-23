class PlansController < ApplicationController

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

  def create
     @plan = Plan.new

     @plan.user_id = params[:user_id]
     @plan.schedule_id = params[:schedule_id]

     if params[:bid].empty?
        @plan.bid = 1
     else
        @plan.bid = params[:bid]
     end

     save_status = @plan.save

     if save_status == true
        redirect_back(fallback_location: root_path)
        flash[:notice] = 'Added to plan!'
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
