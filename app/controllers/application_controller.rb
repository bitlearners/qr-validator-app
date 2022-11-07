class ApplicationController < ActionController::Base
  helper_method :current_user, :user
  before_action :authenticate_user, except: %i[signup login]

  attr_reader :user_db_instance

  def current_user
    #@current_user ||= create_new_user
    @current_user_id ||= session[:user_id]
  end

  def user
    return unless current_user
    fetch_user_data
  end

  private

  # fetch only one User data from Firebase
  def fetch_user_data
    #binding.pry
    return unless session[:user_id]
    user_db_path = ENV["firebase_user_db_root_path"]
    path = user_db_path + "/" + session[:user_id]
    data = conn.get(path).body
    #binding.pry
    return nil if (data.nil? || data.include?("error") )
    params = {
      "id": session[:user_id],
      "email": session["data"]["email"],
      "name": data['name'],
      "cam_pref": data['cam_pref'],
      "qr_scan_count": data['qr_scan_count']
    }.compact
    User.new(params) if params.present?
  end

  def create_new_user
    return unless current_user_data_params
    user = User.new(current_user_data_params)
    #binding.pry
    user.update_db
    user
  end


  def current_user_data_params  ## create new USER
    return unless session[:user_id]
    {
      "id": session[:user_id],
      "email": session["data"]["email"],
      "name": session["data"]['name'],
      "cam_pref": session["data"]['cam_pref'],
      "qr_scan_count": session["data"]['qr_scan_count']
    }
  end



end
