Rails.application.routes.draw do
   devise_for :admins
    devise_for :users, controllers: {
       registrations: 'users/registrations'
    }

    authenticated :user do
       root 'courses#index', as: :authenticated_root
    end

    root 'welcome#welcome'


   # Routes to view mailer templates
   get "/test/plan", :controller => "mailtesting", :action => "test_plan"
   get "/test/welcome", :controller => "mailtesting", :action => "test_welcome"
   get "/test/confirm", :controller => "mailtesting", :action => "test_confirm"

   # Routes for the Plan resource:
   # CREATE
   get "/plans/new", :controller => "plans", :action => "new"
   post "/create_plan", :controller => "plans", :action => "create"

   # READ
   get "/hot", :controller => "plans", :action => "hot"
   get "/plans", :controller => "plans", :action => "index"
   get "/plans/stats", controller: "plans", action: "stat_form"
   get "/plans/build_stats", controller: "plans", action: "stat_results"
   # get "/plans/:id", :controller => "plans", :action => "show"
   get "generate_plan", :controller => 'plans', :action => 'mail'
   post '/add', :controller => 'plans', :action => 'create'

   # UPDATE
   # get "/plans/:id/edit", :controller => "plans", :action => "edit"
   # post "/update_plan/:id", :controller => "plans", :action => "update"

   # DELETE
   get "/delete_plan/:id", :controller => "plans", :action => "destroy"
   #------------------------------

   # Routes for Landing Page of Unauthenticated Users
   get '/welcome', :controller => 'welcome', :action => 'welcome'
   get '/acknowledgements', :controller => 'welcome', :action => 'ack'
   get '/about', :controller => 'welcome', :action => 'about'


  # Routes for the Schedule resource:
  # CREATE
  get "/schedules/new", :controller => "schedules", :action => "new"
  post "/create_schedule", :controller => "schedules", :action => "create"

  # READ
  get "/schedules", :controller => "schedules", :action => "index"
  get "/schedules/:id", :controller => "schedules", :action => "show"

  # UPDATE
  get "/schedules/:id/edit", :controller => "schedules", :action => "edit"
  post "/update_schedule/:id", :controller => "schedules", :action => "update"

  # DELETE
  get "/delete_schedule/:id", :controller => "schedules", :action => "destroy"
  #------------------------------

  # Routes for the Section resource:
  # CREATE
  get "/sections/new", :controller => "sections", :action => "new"
  post "/create_section", :controller => "sections", :action => "create"

  # READ
  get "/sections", :controller => "sections", :action => "index"
  get "/sections/:id", :controller => "sections", :action => "show"


  # UPDATE
  get "/sections/:id/edit", :controller => "sections", :action => "edit"
  post "/update_section/:id", :controller => "sections", :action => "update"

  # DELETE
  get "/delete_section/:id", :controller => "sections", :action => "destroy"
  #------------------------------

  # Routes for the Evaluation resource:
  # CREATE
  get "/evaluations/new", :controller => "evaluations", :action => "new"
  post "/create_evaluation", :controller => "evaluations", :action => "create"

  # READ
  get "/evaluations", :controller => "evaluations", :action => "index"
  get "/evaluations/:id", :controller => "evaluations", :action => "show"

  # UPDATE
  get "/evaluations/:id/edit", :controller => "evaluations", :action => "edit"
  post "/update_evaluation/:id", :controller => "evaluations", :action => "update"

  # DELETE
  get "/delete_evaluation/:id", :controller => "evaluations", :action => "destroy"
  #------------------------------

  # Routes for the Professor resource:
  # CREATE
  get "/professors/new", :controller => "professors", :action => "new"
  post "/create_professor", :controller => "professors", :action => "create"

  # READ
  get "/professors", :controller => "professors", :action => "index"
  get "/professors/:id", :controller => "professors", :action => "show"

  # UPDATE
  get "/professors/:id/edit", :controller => "professors", :action => "edit"
  post "/update_professor/:id", :controller => "professors", :action => "update"

  # DELETE
  get "/delete_professor/:id", :controller => "professors", :action => "destroy"
  #------------------------------

  # Routes for the Course resource:
  # CREATE

  get "/courses/new", :controller => "courses", :action => "new"
  post "/create_course", :controller => "courses", :action => "create"

  # READ
  get "/courses", :controller => "courses", :action => "index"
  get "/courses/:quarter", :controller => "courses", :action => "index"
  get "/query_courses", :controller => "courses", :action => "index"

  # UPDATE
  get "/courses/:id/edit", :controller => "courses", :action => "edit"
  post "/update_course/:id", :controller => "courses", :action => "update"

  # DELETE
  get "/delete_course/:id", :controller => "courses", :action => "destroy"
  #------------------------------

  #-------------------------------------------
  # API Calls
  get "/api", controller: "api", action: "provide_data"
  get "/init_api", controller: "api", action: "multi_load"
  #-------------------------------------------

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
