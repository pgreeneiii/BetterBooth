class ApiController < ApplicationController

   def multi_load
      # Use number of cards on page to determine how much data to create
      card_count = params[:card_count].to_i
      # Set card count to a zero index
      zero_index_count = card_count-1

      # Create empty hash to store data
      response_data = {}

      # Create array using card count
      loop_array=*(0..zero_index_count)

      # Build a unique hash of hashes for each card and store as card_index
      loop_array.each do |index|
         prof_id = params[index.to_s][0].to_i
         course_id = params[index.to_s][1].to_i

         # Query for Section
         section = Section.find_by(course_id: course_id, professor_id: prof_id)
         course_sched_count = Course.find(course_id).schedules.count

         # For each schedule in section, build schedule data
         schedules = []
         section.schedules.each do |schedule|
            # Determine if user already has plan stored for this schedule
            plans = current_user.plans.where(schedule_id: schedule.id)
            if plans.empty?
               plan_status = 0
            else
               # if plan exists, store plan.id as plan_status
               plan_status = plans.first.id
            end

            temp_hash = {id: schedule.id, section_number: schedule.section_number, day: schedule.daytable.day_output, time: schedule.timetable.time_output, plan: plan_status}

            schedules.push(temp_hash)
         end

         # Check if bid data exists and build bid object
         if section.bids.empty?
            bid_status = 0
            bid = "No Bid Data"
         else
            bid_status = 1

            bid = section.bids.order(year: :desc, quarter_id: :asc, time_id: :asc).first
            bids = {id: bid.id, quarter: bid.quartertable.quarter_output,
               year: bid.year, p1_price: bid.p1_price, p2_price: bid.p2_price, p3_price: bid.p3_price, p4_price: bid.p4_price}
         end

         # Check if rating data exists and build rating object
         if section.ratings.empty?
            rating_status = 0
            rating = "No Rating Data"
         else
            rating_status = 1

            rating = section.ratings.order(year: :desc, quarter_id: :asc, section_number: :asc).first
            ratings = {id: rating.id, quarter:
               rating.quartertable.quarter_output, year: rating.year, avg_hours: rating.avg_hours, comms_median: rating.comms_median, engaging_median: rating.engaging_median, practical_median: rating.practical_median, amt_learned_median: rating.amt_learned_median, recommend_median: rating.recommend_median}
         end

         # Set object key so there is consistent syntax for jquery functions
         key = "card_#{index}"

         # Store hash in response data using set key
         response_data[key] = {
            section_id: section.id,
            course_id: course_id,
            course_number: section.course.course_number,
            course_sched_count: course_sched_count,
            schedules: schedules,
            bid_status: bid_status,
            bids: bids,
            rating_status: rating_status,
            ratings: ratings
         }
      end

      # Build json response (max cards is 24)
      status = :ok
      response = {
         status: 'ok',
         card_count: card_count,
         card_0: response_data["card_0"],
         card_1: response_data["card_1"],
         card_2: response_data["card_2"],
         card_3: response_data["card_3"],
         card_4: response_data["card_4"],
         card_5: response_data["card_5"],
         card_6: response_data["card_6"],
         card_7: response_data["card_7"],
         card_8: response_data["card_8"],
         card_9: response_data["card_9"],
         card_10: response_data["card_10"],
         card_11: response_data["card_11"],
         card_12: response_data["card_12"],
         card_13: response_data["card_13"],
         card_14: response_data["card_14"],
         card_15: response_data["card_15"],
         card_16: response_data["card_16"],
         card_17: response_data["card_17"],
         card_18: response_data["card_18"],
         card_19: response_data["card_19"],
         card_20: response_data["card_20"],
         card_21: response_data["card_21"],
         card_22: response_data["card_22"],
         card_23: response_data["card_23"]
      }
      render_json(response, status)
   end

   def provide_data
      course_id = params[:course_id]
      professor_id = params[:prof_id]

      # Query for Section
      section = Section.find_by(course_id: course_id, professor_id: professor_id)
      course_sched_count = Course.find(course_id).schedules.count

      # For each schedule in section, build schedule data
      schedules = []
      section.schedules.each do |schedule|
         # Determine if user already has plan stored for this schedule
         plans = Plan.where(user_id: current_user.id, schedule_id: schedule.id)
         if plans.empty?
            plan_status = 0
         else
            # if plan exists, store plan.id as plan_status
            plan_status = plans.first.id
         end

         temp_hash = {id: schedule.id, section_number: schedule.section_number, day: schedule.daytable.day_output, time: schedule.timetable.time_output, plan: plan_status}

         schedules.push(temp_hash)
      end

      # Check if bid data exists and build bid object
      if section.bids.empty?
         bid_status = 0
         bid = "No Bid Data"
      else
         bid_status = 1

      bid = section.bids.order(year: :desc, quarter_id: :asc, time_id: :asc).first
      bids = {id: bid.id, quarter: bid.quartertable.quarter_output,
         year: bid.year, p1_price: bid.p1_price, p2_price: bid.p2_price, p3_price: bid.p3_price, p4_price: bid.p4_price}
      end

      # Check if rating data exists and build rating object
      if section.ratings.empty?
         rating_status = 0
         rating = "No Rating Data"
      else
      rating_status = 1

      rating = section.ratings.order(year: :desc, quarter_id: :asc, section_number: :asc).first
      ratings = {id: rating.id, quarter:
         rating.quartertable.quarter_output, year: rating.year, avg_hours: rating.avg_hours, comms_median: rating.comms_median, engaging_median: rating.engaging_median, practical_median: rating.practical_median, amt_learned_median: rating.amt_learned_median, recommend_median: rating.recommend_median}
      end

      # Store hash in response data
      status = :ok
      response = {
         status: 'ok',
         section_id: section.id,
         course_id: course_id,
         course_number: section.course.course_number,
         course_sched_count: course_sched_count,
         schedules: schedules,
         bid_status: bid_status,
         bids: bids,
         rating_status: rating_status,
         ratings: ratings
      }

      render_json(response, status)
   end

   # Function to render json data
   def render_json(response, status)
      render json: response, status: status
   end
end
