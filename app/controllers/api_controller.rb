class ApiController < ApplicationController

   def provide_data
      course_id = params[:course_id]
      professor_id = params[:prof_id]
      section = Section.find_by(course_id: course_id, professor_id: professor_id)

      course_sched_count = Course.find(course_id).schedules.count

      schedules = []
      section.schedules.each do |schedule|
         temp_hash = {id: schedule.id, section_number: schedule.section_number, day: schedule.daytable.day_output, time: schedule.timetable.time_output}

         schedules.push(temp_hash)
      end

      if section.bids.empty?
         bid_status = 0
         bid = "No Bid Data"
      else
         bid_status = 1

         bid = section.bids.order(year: :desc, quarter_id: :asc).first
         bids = {id: bid.id, quarter: bid.quartertable.quarter_output,
            year: bid.year, p1_price: bid.p1_price, p2_price: bid.p2_price, p3_price: bid.p3_price, p4_price: bid.p4_price}
      end

      if section.ratings.empty?
         rating_status = 0
         rating = "No Rating Data"
      else
         rating_status = 1

         rating = section.ratings.order(year: :desc, quarter_id: :asc).first
         ratings = {id: rating.id, quarter:
            rating.quartertable.quarter_output, year: rating.year, avg_hours: rating.avg_hours, comms_median: rating.comms_median, engaging_median: rating.engaging_median, practical_median: rating.practical_median, amt_learned_median: rating.amt_learned_median, recommend_median: rating.recommend_median}
      end

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

   def render_json(response, status)
      render json: response, status: status
   end
end
