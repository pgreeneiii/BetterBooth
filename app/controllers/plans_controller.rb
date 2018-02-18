class PlansController < ApplicationController

   def hot
      a_effort = Section.find(10)
      a_rating = Section.find(9)

      m_effort = Section.find(35)
      m_rating = Section.find(35)

      core_f_effort = Section.find(122)
      core_f_rating = Section.find(106)

      core_m_effort = Section.find(163)
      core_m_rating = Section.find(175)

      core_o_effort = Section.find(237)
      core_o_rating = Section.find(231)

      core_d_effort = Section.find(194)
      core_d_rating = Section.find(194)

      core_p_effort = Section.find(190)
      core_p_rating = Section.find(38)

      core_s_effort = Section.find(222)
      core_s_rating = Section.find(272)

      core_b_effort = Section.find(59)
      core_b_rating = Section.find(59)

      @foundations = {
         accounting: {
            effort: {
               id: a_effort.id,
               course: a_effort.course.course_name,
               professor: "#{a_effort.professor.first_name} #{a_effort.professor.last_name}",
               avg_hours: a_effort.ratings.average(:avg_hours).to_f.round(2),
               engaging: a_effort.ratings.average(:engaging_mean).to_f.round(2),
               amt_learned: a_effort.ratings.average(:amt_learned_mean).to_f.round(2),
               comms: a_effort.ratings.average(:comms_mean).to_f.round(2),
               practical: a_effort.ratings.average(:practical_mean).to_f.round(2),
               recommend: a_effort.ratings.average(:recommend_mean).to_f.round(2),
               cost: a_effort.bids.average(:p1_price).to_f.round(2)
            },
            rating: {
               id: a_rating.id,
               course: a_rating.course.course_name,
               professor: "#{a_rating.professor.first_name} #{a_rating.professor.last_name}",
               avg_hours: a_rating.ratings.average(:avg_hours).to_f.round(2),
               engaging: a_rating.ratings.average(:engaging_mean).to_f.round(2),
               amt_learned: a_rating.ratings.average(:amt_learned_mean).to_f.round(2),
               comms: a_rating.ratings.average(:comms_mean).to_f.round(2),
               practical: a_rating.ratings.average(:practical_mean).to_f.round(2),
               recommend: a_rating.ratings.average(:recommend_mean).to_f.round(2),
               cost: a_rating.bids.average(:p1_price).to_f.round(2)
            }
         },
         microeconomics: {
            effort: {
               id: m_effort.id,
               course: m_effort.course.course_name,
               professor: "#{m_effort.professor.first_name} #{m_effort.professor.last_name}",
               avg_hours: m_effort.ratings.average(:avg_hours).to_f.round(2),
               engaging: m_effort.ratings.average(:engaging_mean).to_f.round(2),
               amt_learned: m_effort.ratings.average(:amt_learned_mean).to_f.round(2),
               comms: m_effort.ratings.average(:comms_mean).to_f.round(2),
               practical: m_effort.ratings.average(:practical_mean).to_f.round(2),
               recommend: m_effort.ratings.average(:recommend_mean).to_f.round(2),
               cost: m_effort.bids.average(:p1_price).to_f.round(2)
            },
            rating: {
               id: m_rating.id,
               course: m_rating.course.course_name,
               professor: "#{m_rating.professor.first_name} #{m_rating.professor.last_name}",
               avg_hours: m_rating.ratings.average(:avg_hours).to_f.round(2),
               engaging: m_rating.ratings.average(:engaging_mean).to_f.round(2),
               amt_learned: m_rating.ratings.average(:amt_learned_mean).to_f.round(2),
               comms: m_rating.ratings.average(:comms_mean).to_f.round(2),
               practical: m_rating.ratings.average(:practical_mean).to_f.round(2),
               recommend: m_rating.ratings.average(:recommend_mean).to_f.round(2),
               cost: m_rating.bids.average(:p1_price).to_f.round(2)
            }
         }
      }

      @core = {
         finance: {
            effort: {
               id: core_f_effort.id,
               course: core_f_effort.course.course_name,
               professor: "#{core_f_effort.professor.first_name} #{core_f_effort.professor.last_name}",
               avg_hours: core_f_effort.ratings.average(:avg_hours).to_f.round(2),
               engaging: core_f_effort.ratings.average(:engaging_mean).to_f.round(2),
               amt_learned: core_f_effort.ratings.average(:amt_learned_mean).to_f.round(2),
               comms: core_f_effort.ratings.average(:comms_mean).to_f.round(2),
               practical: core_f_effort.ratings.average(:practical_mean).to_f.round(2),
               recommend: core_f_effort.ratings.average(:recommend_mean).to_f.round(2),
               cost: core_f_effort.bids.average(:p1_price).to_f.round(2)
            },
            rating: {
               id: core_f_rating.id,
               course: core_f_rating.course.course_name,
               professor: "#{core_f_rating.professor.first_name} #{core_f_rating.professor.last_name}",
               avg_hours: core_f_rating.ratings.average(:avg_hours).to_f.round(2),
               engaging: core_f_rating.ratings.average(:engaging_mean).to_f.round(2),
               amt_learned: core_f_rating.ratings.average(:amt_learned_mean).to_f.round(2),
               comms: core_f_rating.ratings.average(:comms_mean).to_f.round(2),
               practical: core_f_rating.ratings.average(:practical_mean).to_f.round(2),
               recommend: core_f_rating.ratings.average(:recommend_mean).to_f.round(2),
               cost: core_f_rating.bids.average(:p1_price).to_f.round(2)
            }
         },
         marketing: {
            effort: {
               id: core_m_effort.id,
               course: core_m_effort.course.course_name,
               professor: "#{core_m_effort.professor.first_name} #{core_m_effort.professor.last_name}",
               avg_hours: core_m_effort.ratings.average(:avg_hours).to_f.round(2),
               engaging: core_m_effort.ratings.average(:engaging_mean).to_f.round(2),
               amt_learned: core_m_effort.ratings.average(:amt_learned_mean).to_f.round(2),
               comms: core_m_effort.ratings.average(:comms_mean).to_f.round(2),
               practical: core_m_effort.ratings.average(:practical_mean).to_f.round(2),
               recommend: core_m_effort.ratings.average(:recommend_mean).to_f.round(2),
               cost: core_m_effort.bids.average(:p1_price).to_f.round(2)
            },
            rating: {
               id: core_m_rating.id,
               course: core_m_rating.course.course_name,
               professor: "#{core_m_rating.professor.first_name} #{core_m_rating.professor.last_name}",
               avg_hours: core_m_rating.ratings.average(:avg_hours).to_f.round(2),
               engaging: core_m_rating.ratings.average(:engaging_mean).to_f.round(2),
               amt_learned: core_m_rating.ratings.average(:amt_learned_mean).to_f.round(2),
               comms: core_m_rating.ratings.average(:comms_mean).to_f.round(2),
               practical: core_m_rating.ratings.average(:practical_mean).to_f.round(2),
               recommend: core_m_rating.ratings.average(:recommend_mean).to_f.round(2),
               cost: core_m_rating.bids.average(:p1_price).to_f.round(2)
            }
         },
         operations: {
            effort: {
               id: core_o_effort.id,
               course: core_o_effort.course.course_name,
               professor: "#{core_o_effort.professor.first_name} #{core_o_effort.professor.last_name}",
               avg_hours: core_o_effort.ratings.average(:avg_hours).to_f.round(2),
               engaging: core_o_effort.ratings.average(:engaging_mean).to_f.round(2),
               amt_learned: core_o_effort.ratings.average(:amt_learned_mean).to_f.round(2),
               comms: core_o_effort.ratings.average(:comms_mean).to_f.round(2),
               practical: core_o_effort.ratings.average(:practical_mean).to_f.round(2),
               recommend: core_o_effort.ratings.average(:recommend_mean).to_f.round(2),
               cost: core_o_effort.bids.average(:p1_price).to_f.round(2)
            },
            rating: {
               id: core_o_rating.id,
               course: core_o_rating.course.course_name,
               professor: "#{core_o_rating.professor.first_name} #{core_o_rating.professor.last_name}",
               avg_hours: core_o_rating.ratings.average(:avg_hours).to_f.round(2),
               engaging: core_o_rating.ratings.average(:engaging_mean).to_f.round(2),
               amt_learned: core_o_rating.ratings.average(:amt_learned_mean).to_f.round(2),
               comms: core_o_rating.ratings.average(:comms_mean).to_f.round(2),
               practical: core_o_rating.ratings.average(:practical_mean).to_f.round(2),
               recommend: core_o_rating.ratings.average(:recommend_mean).to_f.round(2),
               cost: core_o_rating.bids.average(:p1_price).to_f.round(2)
            }
         },
         decisions: {
            effort: {
               id: core_d_effort.id,
               course: core_d_effort.course.course_name,
               professor: "#{core_d_effort.professor.first_name} #{core_d_effort.professor.last_name}",
               avg_hours: core_d_effort.ratings.average(:avg_hours).to_f.round(2),
               engaging: core_d_effort.ratings.average(:engaging_mean).to_f.round(2),
               amt_learned: core_d_effort.ratings.average(:amt_learned_mean).to_f.round(2),
               comms: core_d_effort.ratings.average(:comms_mean).to_f.round(2),
               practical: core_d_effort.ratings.average(:practical_mean).to_f.round(2),
               recommend: core_d_effort.ratings.average(:recommend_mean).to_f.round(2),
               cost: core_d_effort.bids.average(:p1_price).to_f.round(2)
            },
            rating: {
               id: core_d_rating.id,
               course: core_d_rating.course.course_name,
               professor: "#{core_d_rating.professor.first_name} #{core_d_rating.professor.last_name}",
               avg_hours: core_d_rating.ratings.average(:avg_hours).to_f.round(2),
               engaging: core_d_rating.ratings.average(:engaging_mean).to_f.round(2),
               amt_learned: core_d_rating.ratings.average(:amt_learned_mean).to_f.round(2),
               comms: core_d_rating.ratings.average(:comms_mean).to_f.round(2),
               practical: core_d_rating.ratings.average(:practical_mean).to_f.round(2),
               recommend: core_d_rating.ratings.average(:recommend_mean).to_f.round(2),
               cost: core_d_rating.bids.average(:p1_price).to_f.round(2)
            }
         },
         people: {
            effort: {
               id: core_p_effort.id,
               course: core_p_effort.course.course_name,
               professor: "#{core_p_effort.professor.first_name} #{core_p_effort.professor.last_name}",
               avg_hours: core_p_effort.ratings.average(:avg_hours).to_f.round(2),
               engaging: core_p_effort.ratings.average(:engaging_mean).to_f.round(2),
               amt_learned: core_p_effort.ratings.average(:amt_learned_mean).to_f.round(2),
               comms: core_p_effort.ratings.average(:comms_mean).to_f.round(2),
               practical: core_p_effort.ratings.average(:practical_mean).to_f.round(2),
               recommend: core_p_effort.ratings.average(:recommend_mean).to_f.round(2),
               cost: core_p_effort.bids.average(:p1_price).to_f.round(2)
            },
            rating: {
               id: core_p_rating.id,
               course: core_p_rating.course.course_name,
               professor: "#{core_p_rating.professor.first_name} #{core_p_rating.professor.last_name}",
               avg_hours: core_p_rating.ratings.average(:avg_hours).to_f.round(2),
               engaging: core_p_rating.ratings.average(:engaging_mean).to_f.round(2),
               amt_learned: core_p_rating.ratings.average(:amt_learned_mean).to_f.round(2),
               comms: core_p_rating.ratings.average(:comms_mean).to_f.round(2),
               practical: core_p_rating.ratings.average(:practical_mean).to_f.round(2),
               recommend: core_p_rating.ratings.average(:recommend_mean).to_f.round(2),
               cost: core_p_rating.bids.average(:p1_price).to_f.round(2)
            }
         },
         strategy: {
            effort: {
               id: core_s_effort.id,
               course: core_s_effort.course.course_name,
               professor: "#{core_s_effort.professor.first_name} #{core_s_effort.professor.last_name}",
               avg_hours: core_s_effort.ratings.average(:avg_hours).to_f.round(2),
               engaging: core_s_effort.ratings.average(:engaging_mean).to_f.round(2),
               amt_learned: core_s_effort.ratings.average(:amt_learned_mean).to_f.round(2),
               comms: core_s_effort.ratings.average(:comms_mean).to_f.round(2),
               practical: core_s_effort.ratings.average(:practical_mean).to_f.round(2),
               recommend: core_s_effort.ratings.average(:recommend_mean).to_f.round(2),
               cost: core_s_effort.bids.average(:p1_price).to_f.round(2)
            },
            rating: {
               id: core_s_rating.id,
               course: core_s_rating.course.course_name,
               professor: "#{core_s_rating.professor.first_name} #{core_s_rating.professor.last_name}",
               avg_hours: core_s_rating.ratings.average(:avg_hours).to_f.round(2),
               engaging: core_s_rating.ratings.average(:engaging_mean).to_f.round(2),
               amt_learned: core_s_rating.ratings.average(:amt_learned_mean).to_f.round(2),
               comms: core_s_rating.ratings.average(:comms_mean).to_f.round(2),
               practical: core_s_rating.ratings.average(:practical_mean).to_f.round(2),
               recommend: core_s_rating.ratings.average(:recommend_mean).to_f.round(2),
               cost: core_s_rating.bids.average(:p1_price).to_f.round(2)
            }
         },
         business: {
            effort: {
               id: core_b_effort.id,
               course: core_b_effort.course.course_name,
               professor: "#{core_b_effort.professor.first_name} #{core_b_effort.professor.last_name}",
               avg_hours: core_b_effort.ratings.average(:avg_hours).to_f.round(2),
               engaging: core_b_effort.ratings.average(:engaging_mean).to_f.round(2),
               amt_learned: core_b_effort.ratings.average(:amt_learned_mean).to_f.round(2),
               comms: core_b_effort.ratings.average(:comms_mean).to_f.round(2),
               practical: core_b_effort.ratings.average(:practical_mean).to_f.round(2),
               recommend: core_b_effort.ratings.average(:recommend_mean).to_f.round(2),
               cost: core_b_effort.bids.average(:p1_price).to_f.round(2)
            },
            rating: {
               id: core_b_rating.id,
               course: core_b_rating.course.course_name,
               professor: "#{core_b_rating.professor.first_name} #{core_b_rating.professor.last_name}",
               avg_hours: core_b_rating.ratings.average(:avg_hours).to_f.round(2),
               engaging: core_b_rating.ratings.average(:engaging_mean).to_f.round(2),
               amt_learned: core_b_rating.ratings.average(:amt_learned_mean).to_f.round(2),
               comms: core_b_rating.ratings.average(:comms_mean).to_f.round(2),
               practical: core_b_rating.ratings.average(:practical_mean).to_f.round(2),
               recommend: core_b_rating.ratings.average(:recommend_mean).to_f.round(2),
               cost: core_b_rating.bids.average(:p1_price).to_f.round(2)
            }
         }
      }
      render("plans/hot_takes.html.erb")
   end

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
