class SectionsController < ApplicationController
  def index
    @sections = Section.all

    render("sections/index.html.erb")
  end

  def show
    @section = Section.find(params[:id])

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
end
