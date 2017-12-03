class SectionsController < ApplicationController

  def index
    @sections = Section.all

    render("sections/index.html.erb")
  end

  def show
    @section = Section.find(params[:id])

    result = [['ID', 'Time', 'Quarter', 'Phase', 'Price']]

      @section.bids.order(year: :asc, quarter_id: :asc, time_id: :asc).each do |bid|
         time = bid.time_id
         if bid.time_id > 3
            time = 4
         end

         if bid.quarter_id == 1
            quarter = 2
         elsif bid.quarter_id == 2
            quarter = 3
         elsif bid.quarter_id == 3
            quarter = 4
         elsif bid.quarter_id == 4
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

    respond_to do |format|
        format.html # show.html.erb
        format.json { render json: result }
    end

    # render("sections/show.html.erb")
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
