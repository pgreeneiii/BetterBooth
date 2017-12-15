class SectionsController < ApplicationController

  def index
    @sections = Section.all

    render("sections/index.html.erb")
  end

  def show
    @section = Section.find(params[:id])
    @ratings = @section.ratings

    if @ratings.empty?
      puts "No Rating to Load"
    else
      hours, comms, engage, prac, learn, rec = [], [], [], [], [], []
      hist_avg_hours = []

      minimums = [@ratings.minimum(:comms_mean), @ratings.minimum(:engaging_mean), @ratings.minimum(:practical_mean), @ratings.minimum(:amt_learned_mean), @ratings.minimum(:recommend_mean)]

      @minimum = minimums.min.floor

       @ratings.order(year: :asc, quarter_id: :desc).each do |rating|
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

       @mean_data = [
          # {name: "Avg. Hours", data: hours},
          {name: "Avg. Communication Score", data: comms},
          {name: "Avg. Engagement Score", data: engage},
          {name: "Avg. Practicality Score", data: prac},
          {name: "Avg. Amount Learned Score", data: learn},
          {name: "Avg. Recommendation Score", data: rec}
       ]

       @hours_data = [
         {name: "Avg. Hours", data: hours},
         {name: "All Booth Courses Historic Avg.", data: hist_avg_hours}
       ]

    end

    render("sections/show.html.erb")
  end

  def new
    @section = Section.new

    render("sections/new.html.erb")
  end

  def create
    @section = Section.new

    @section.course_id = params[:course_id]
    @section.professor_id = params[:professor_id]
    @section.content = params[:content]

    save_status = @section.save

    if save_status == true
      redirect_to("/sections/#{@section.id}", :notice => "Section created successfully.")
    else
      render("sections/new.html.erb")
    end
  end

  def edit
    @section = Section.find(params[:id])

    render("sections/edit.html.erb")
  end

  def update
    @section = Section.find(params[:id])

    @section.course_id = params[:course_id]
    @section.professor_id = params[:professor_id]
    @section.content = params[:content]

    save_status = @section.save

    if save_status == true
      redirect_to("/sections/#{@section.id}", :notice => "Section updated successfully.")
    else
      render("sections/edit.html.erb")
    end
  end

  def destroy
    @section = Section.find(params[:id])

    @section.destroy

    if URI(request.referer).path == "/sections/#{@section.id}"
      redirect_to("/", :notice => "Section deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Section deleted.")
    end
  end

  def data
     result = [['ID', 'Time', 'Quarter', 'Phase', 'Price']]

     @section.bids.order(year: :asc, quarter_id: :asc, time_id: :asc).each do |bid|
      time = time_id
      if time_id > 3
          time = 4
      end

      if quarter_id == 1
          quarter = 2
      elsif quarter_id == 2
          quarter = 3
      elsif quarter_id == 3
          quarter = 4
      elsif quarter_id == 4
          quarter = 1
      else
          quarter = 5
      end

      data = [bid.year, time, quarter, 'Phase 1', bid.p1_price]
      result.push(data)
      data = [bid.year, time, quarter, 'Phase 2', bid.p2_price]
      result.push(data)
      data = [bid.year, time, quarter, 'Phase 3', bid.p3_price]
      result.push(data)
      data = [bid.year, time, quarter, 'Phase 4', bid.p4_price]
      result.push(data)
     end

     render json: result
  end

end
