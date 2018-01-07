class CoursesController < ApplicationController
   before_action :set_course_page

  def index
     default = 3

     if params[:quarter].nil?
        @quarter = default
     elsif params[:quarter].length > 1
        if params[:quarter] == 'winter'
           @quarter = 4
        elsif params[:quarter] == 'spring'
           @quarter = 3
        elsif params[:quarter] == 'summer'
           @quarter = 2
        elsif params[:quarter] == 'fall'
           @quarter = 1
        elsif params[:quarter] == 'autumn'
           @quarter = 1
        else
           @quarter = default
        end
     elsif ((params[:quarter].to_i < 1) || (params[:quarter].to_i > 4))
        @quarter = default
     else
        @quarter = params[:quarter].to_i
     end
      # Load selected courses
      @q = Course.joins(:schedules).where(
         'schedules.quarter = ?', @quarter).distinct.ransack(params[:q])

      # Load selected courses
      @courses = @q.result(distinct: true).includes(:professors, :schedules).page(params[:page]).per(24)

      @title = QuarterTable.find(@quarter).quarter_output

      render("courses/index.html.erb")
  end

  def set_course_page
     @course_page = true
  end

  # def show
  #     @course = Course.find(params[:id])
  #
  #     render("courses/show.html.erb")
  # end
  #
  # def new
  #     @course = Course.new
  #
  #     render("courses/new.html.erb")
  # end

  # def create
  #     @course = Course.new
  #
  #     @course.course_number = params[:course_number]
  #     @course.course_name = params[:course_name]
  #     @course.subject = params[:subject]
  #
  #     save_status = @course.save
  #
  #     if save_status == true
  #        redirect_to("/courses/#{@course.id}", :notice => "Course created successfully.")
  #     else
  #        render("courses/new.html.erb")
  #     end
  # end

   # def edit
   #    @course = Course.find(params[:id])
   #
   #    render("courses/edit.html.erb")
   # end

   # def update
   #    @course = Course.find(params[:id])
   #
   #    @course.course_number = params[:course_number]
   #    @course.course_name = params[:course_name]
   #    @course.subject = params[:subject]
   #
   #    save_status = @course.save
   #
   #    if save_status == true
   #       redirect_to("/courses/#{@course.id}", :notice => "Course updated successfully.")
   #    else
   #       render("courses/edit.html.erb")
   #    end
   # end

   # def destroy
   #    @course = Course.find(params[:id])
   #
   #    @course.destroy
   #
   #    if URI(request.referer).path == "/courses/#{@course.id}"
   #       redirect_to("/", :notice => "Course deleted.")
   #    else
   #       redirect_back(:fallback_location => "/", :notice => "Course deleted.")
   #    end
   # end
end
