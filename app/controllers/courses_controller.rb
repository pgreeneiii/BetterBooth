class CoursesController < ApplicationController
  def index
    @q = Course.joins(:schedules).where('schedules.quarter = 4').distinct.ransack(params[:q])
    @courses = @q.result(distinct: true).includes(:professors, :schedules)

    render("courses/index.html.erb")
  end

  def show
    @course = Course.find(params[:id])

    render("courses/show.html.erb")
  end

  def new
    @course = Course.new

    render("courses/new.html.erb")
  end

  def create
    @course = Course.new

    @course.course_number = params[:course_number]
    @course.course_name = params[:course_name]
    @course.subject = params[:subject]

    save_status = @course.save

    if save_status == true
      redirect_to("/courses/#{@course.id}", :notice => "Course created successfully.")
    else
      render("courses/new.html.erb")
    end
  end

  def edit
    @course = Course.find(params[:id])

    render("courses/edit.html.erb")
  end

  def update
    @course = Course.find(params[:id])

    @course.course_number = params[:course_number]
    @course.course_name = params[:course_name]
    @course.subject = params[:subject]

    save_status = @course.save

    if save_status == true
      redirect_to("/courses/#{@course.id}", :notice => "Course updated successfully.")
    else
      render("courses/edit.html.erb")
    end
  end

  def destroy
    @course = Course.find(params[:id])

    @course.destroy

    if URI(request.referer).path == "/courses/#{@course.id}"
      redirect_to("/", :notice => "Course deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Course deleted.")
    end
  end
end
