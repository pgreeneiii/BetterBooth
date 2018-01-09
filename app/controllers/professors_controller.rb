class ProfessorsController < ApplicationController
   before_filter :authorize_admin

   def index
      @professors = Professor.all

      render("professors/index.html.erb")
   end

   def show
      @professor = Professor.find(params[:id])

      render("professors/show.html.erb")
   end

   def new
      @professor = Professor.new

      render("professors/new.html.erb")
   end

   def create
      @professor = Professor.new

      @professor.first_name = params[:first_name]
      @professor.last_name = params[:last_name]
      @professor.email = params[:email]
      @professor.photo_url = params[:photo_url]

      save_status = @professor.save

      if save_status == true
         redirect_to("/professors/#{@professor.id}", :notice => "Professor created successfully.")
      else
         render("professors/new.html.erb")
      end
   end

   def edit
      @professor = Professor.find(params[:id])

      render("professors/edit.html.erb")
   end

   def update
      @professor = Professor.find(params[:id])

      @professor.first_name = params[:first_name]
      @professor.last_name = params[:last_name]
      @professor.email = params[:email]
      @professor.photo_url = params[:photo_url]

      save_status = @professor.save

      if save_status == true
         redirect_to("/professors/#{@professor.id}", :notice => "Professor updated successfully.")
      else
         render("professors/edit.html.erb")
      end
   end

   def destroy
      @professor = Professor.find(params[:id])

      @professor.destroy

      if URI(request.referer).path == "/professors/#{@professor.id}"
         redirect_to("/", :notice => "Professor deleted.")
      else
         redirect_back(:fallback_location => "/", :notice => "Professor deleted.")
      end
   end
end
