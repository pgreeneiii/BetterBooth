class PlansController < ApplicationController

   def stat_form
      # stats = {
      #    "General" => {bid: {
      #       monday:
      #       }},
      #    "Financial Management" => {},
      #    "Accounting" => {},
      #    "Microeconomics" => {},
      #    "Macro/International Business" => {},
      #    "Entrepreneurship" => {},
      #    "Strategic Management" => {},
      #    "Operations Management" => {},
      #    "Marketing Management" => {},
      #    "Managerial and Organizational Behavior" => {},
      #    "Organizations and Markets" => {},
      #    "Statistics" => {}
      # }
      render("plans/stat_form.html.erb")
   end

   def stat_results
      subject = params[:subject]
      day = params[:day]
      time = params[:time]
      phase = params[:phase]


      @subject_check = false || subject.present?
      @schedule_check = false || (day.present? || time.present?)

      if subject.blank?
         subject_output = "Any Subject"
      else
         subject_output = subject
      end

      if day.blank?
         day_output = "Any day"
      else
         day_output = DayTable.find(day).long_output + "s"
      end

      if time == "1"
         time_output = "Morning"
      elsif time == "2"
         time_output = "Afternoon"
      elsif time == "3"
         time_output = "Evening"
      else
         time_output = "All"
      end

      if phase == "1"
         phase_output = "Phase 1"
      elsif phase == "2"
         phase_output = "Phase 2"
      elsif phase == "3"
         phase_output = "Phase 3"
      elsif phase == "4"
         phase_output = "Phase 4"
      else
         phase_output = "Phase 1"
      end

      @outputs = {
         day: day_output,
         time: time_output,
         phase: phase_output,
         subject: subject_output
      }

      bids = Bid.fetch_by_subject(subject)
      ratings = Rating.fetch_by_subject(subject)

      sf_options = {
         "subject" => subject,
         "day" => day,
         "time" => time,
         "phase" => phase
      }
      f_options = {
         "day" => day,
         "time" => time,
         "phase" => phase
      }
      sp_options = {
         "subject" => subject
      }

      @bids = {
         all_filters: {
            mean: bids.average_bid(day, time, phase),
            count: bids.average_bid_count(day, time, phase),
            course_count: Course.bids_count(sf_options)
         },
         schedule_filters: {
            mean: Bid.average_bid(day, time, phase),
            count: Bid.average_bid_count(day, time, phase),
            course_count: Course.bids_count(f_options)
         },
         subject_filters: {
            mean: bids.average_bid("", "", phase),
            count: bids.average_bid_count("", "", phase),
            course_count: Course.bids_count(sp_options)
         },
         general: {
            mean: Bid.average_bid("","",phase),
            count: Bid.all.count,
            course_count: Course.bids_count
         }
      }

      @ratings = {
         filter: {
            enrollment: ratings.average(:enrollment).to_f.round(2),
            avg_hours: ratings.average(:avg_hours).to_f.round(2),
            comms: ratings.average(:comms_mean).to_f.round(2),
            engaging: ratings.average(:engaging_mean).to_f.round(2),
            practical: ratings.average(:practical_mean).to_f.round(2),
            amt_learned: ratings.average(:amt_learned_mean).to_f.round(2),
            recommend: ratings.average(:recommend_mean).to_f.round(2),
            count: ratings.count,
            course_count: Course.ratings_count(subject)
         },
         general: {
            enrollment: Rating.average(:enrollment).to_f.round(2),
            avg_hours: Rating.average(:avg_hours).to_f.round(2),
            comms: Rating.average(:comms_mean).to_f.round(2),
            engaging: Rating.average(:engaging_mean).to_f.round(2),
            practical: Rating.average(:practical_mean).to_f.round(2),
            amt_learned: Rating.average(:amt_learned_mean).to_f.round(2),
            recommend: Rating.average(:recommend_mean).to_f.round(2),
            count: Rating.all.count,
            course_count: Course.ratings_count
         }
      }

      render("plans/stat_results.html.erb")
   end

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
      @plans = current_user.plans.order(bid: :desc)

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
