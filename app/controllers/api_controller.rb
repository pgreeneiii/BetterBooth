class ApiController < ApplicationController
   def provide_data
      render_json(response, status)
   end

   def render_json(response, status)
      render json: response, status: status
   end
end
