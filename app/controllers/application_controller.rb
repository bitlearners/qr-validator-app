class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :authenticate_user, except: %i[signup login]

  def current_user
    @current_user ||= session[:user_id]
  end

end
