class SectionsController < ApplicationController

   # def index
   #    @sections = Section.all
   #
   #    render("sections/index.html.erb")
   # end

   def show
      @section = Section.find(params[:id])
      @ratings = @section.ratings
      @bids = @section.bids

      # If there are ratings, load rating data
      if @ratings.empty?
      puts "No Rating to Load"
      else
         # Create arrays that will be pushed into data hash
         hours, comms, engage, prac, learn, rec = [], [], [], [], [], []
         hist_avg_hours = []

         minimums = [@ratings.minimum(:comms_mean), @ratings.minimum(:engaging_mean), @ratings.minimum(:practical_mean), @ratings.minimum(:amt_learned_mean), @ratings.minimum(:recommend_mean)]

         # Set a minimum for chart to aid viewing
         @minimum = minimums.min.floor

         # Order ratings and push data into arrays
         @ratings.order(year: :asc, quarter_id: :desc).each do |rating|

            # Create discrete x-axis values in format:
            # "Quarter Year (Section Number)"
            quarter = rating.quartertable.quarter_output
            year = rating.year.to_s
            section_num = rating.section_number
            i = "#{quarter} #{year} (#{section_num})"

            data = [i, rating.avg_hours]
            hours.push(data)

            data = [i, 5.78]
            hist_avg_hours.push(data)

            data = [i, rating.comms_mean]
            comms.push(data)

            data = [i, rating.engaging_mean]
            engage.push(data)

            data = [i, rating.practical_mean]
            prac.push(data)

            data = [i, rating.amt_learned_mean]
            learn.push(data)

            data = [i, rating.recommend_mean]
            rec.push(data)
         end

         # Create mean data table for Chartkick High Charts line chart
         @mean_data = [
            {name: "Avg. Communication Score", data: comms},
            {name: "Avg. Engagement Score", data: engage},
            {name: "Avg. Practicality Score", data: prac},
            {name: "Avg. Amount Learned Score", data: learn},
            {name: "Avg. Recommendation Score", data: rec}
         ]

         # Create avg. hours data table for Chartkick High Charts line chart
         @hours_data = [
            {name: "Avg. Hours", data: hours},
            {name: "All Booth Courses Historic Avg.", data: hist_avg_hours}
         ]

      end

      # If there are bids, load bid data
      if @bids.empty?
      else
         # Create arrays for all 4 phases to push into data
         phase1, phase2, phase3, phase4 = [], [], [], []

         # Order bids and push data into arrays
         @bids.order(year: :asc, quarter_id: :desc).each do |bid|

            # Create discrete x-axis values in format: "Quarter Year (Time)"
            quarter = bid.quartertable.quarter_output
            year = bid.year.to_s

            # Set string value based on time_id
            if bid.time_id == 1
               time = "Morning"
            elsif bid.time_id == 2
               time = "Afternoon"
            elsif bid.time_id == 3
               time = "Evening"
            else
               time = "Other"
            end

            i = "#{quarter} #{year} (#{time})"

            # Bid data is negative if bidding was closed
            p1_price = bid.p1_price
            p2_price = bid.p2_price
            p3_price = bid.p3_price
            p4_price = bid.p4_price

            if p1_price < 0
               p1_price = "Closed"
            end

            if p2_price < 0
               p2_price = "Closed"
            end

            if p3_price < 0
               p3_price = "Closed"
            end

            if p4_price < 0
               p4_price = "Closed"
            end

            data = [i, p1_price]
            phase1.push(data)

            data = [i, p2_price]
            phase2.push(data)

            data = [i, p3_price]
            phase3.push(data)

            data = [i, p4_price]
            phase4.push(data)
         end

         # Create bid data table for Chartkick High Charts line chart
         @bid_data = [
            {name: "Phase 1", data: phase1},
            {name: "Phase 2", data: phase2},
            {name: "Phase 3", data: phase3},
            {name: "Phase 4", data: phase4}
         ]
      end

      render("sections/show.html.erb")
   end

   # def new
   #    @section = Section.new
   #
   #    render("sections/new.html.erb")
   # end

   # def create
   #    @section = Section.new
   #
   #    @section.course_id = params[:course_id]
   #    @section.professor_id = params[:professor_id]
   #    @section.content = params[:content]
   #
   #    save_status = @section.save
   #
   #    if save_status == true
   #       redirect_to("/sections/#{@section.id}", :notice => "Section created successfully.")
   #    else
   #       render("sections/new.html.erb")
   #    end
   # end

   # def edit
   #    @section = Section.find(params[:id])
   #
   #    render("sections/edit.html.erb")
   # end

   # def update
   #    @section = Section.find(params[:id])
   #
   #    @section.course_id = params[:course_id]
   #    @section.professor_id = params[:professor_id]
   #    @section.content = params[:content]
   #
   #    save_status = @section.save
   #
   #    if save_status == true
   #       redirect_to("/sections/#{@section.id}", :notice => "Section updated successfully.")
   #    else
   #       render("sections/edit.html.erb")
   #    end
   # end

   # def destroy
   #    @section = Section.find(params[:id])
   #
   #    @section.destroy
   #
   #    if URI(request.referer).path == "/sections/#{@section.id}"
   #       redirect_to("/", :notice => "Section deleted.")
   #    else
   #       redirect_back(:fallback_location => "/", :notice => "Section deleted.")
   #    end
   # end

   # def data
   #    result = [['ID', 'Time', 'Quarter', 'Phase', 'Price']]
   #
   #    @section.bids.order(year: :asc, quarter_id: :asc, time_id: :asc).each do |bid|
   #       time = time_id
   #
   #       if time_id > 3
   #          time = 4
   #       end
   #
   #       if quarter_id == 1
   #          quarter = 2
   #       elsif quarter_id == 2
   #          quarter = 3
   #       elsif quarter_id == 3
   #          quarter = 4
   #       elsif quarter_id == 4
   #          quarter = 1
   #       else
   #          quarter = 5
   #       end
   #
   #       data = [bid.year, time, quarter, 'Phase 1', bid.p1_price]
   #       result.push(data)
   #       data = [bid.year, time, quarter, 'Phase 2', bid.p2_price]
   #       result.push(data)
   #       data = [bid.year, time, quarter, 'Phase 3', bid.p3_price]
   #       result.push(data)
   #       data = [bid.year, time, quarter, 'Phase 4', bid.p4_price]
   #       result.push(data)
   #    end
   #
   #    render json: result
   #
   # end
end
