class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def help
     Helper.instance
  end

  class Helper
     include Singleton
     include ActionView::Helpers::TextHelper
  end

  private
   def authorize_admin
      redirect_to(root_path) unless current_user && current_user.admin?
   end
end
