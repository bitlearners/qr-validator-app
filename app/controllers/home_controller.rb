require 'net/http'
require 'uri'
require 'json'
class HomeController < ApplicationController
  before_action :set_user_data, only: %i[signup login]
  
  def conn
    @conn ||= App.task_reminder_firebase.conn
  end

  def login
    uri = URI("https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=#{ENV['firebase_web_api_key']}")
    return if !params[:email].present?

    response = Net::HTTP.post_form(uri, "email": @email, "password": @password)
    data = JSON.parse(response.body)

    redirect_to login_path, alert: data["error"]["message"] if response.is_a?(Net::HTTPBadRequest)
    if response.is_a?(Net::HTTPSuccess)
      session[:user_id] = data['localId']
      session[:data] = data
      redirect_to root_path, notice: "Logged In successfully" 
    end
  end

  def logout
    session.clear
    redirect_to login_path, notice: "Logged out successfully" 
  end

  def signup
    uri = URI("https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=#{ENV['firebase_web_api_key']}")
    
    return if !params[:email].present?

    response = Net::HTTP.post_form(uri, "email": @email, "password": @password) 
    data = JSON.parse(response.body)
    session[:user_id] = data['localId']
    session[:data] = data
    redirect_to signup_path, alert: data["error"]["message"] if response.is_a?(Net::HTTPBadRequest)
    redirect_to root_path, notice: "Signed up successfully" if response.is_a?(Net::HTTPSuccess)
    
  end

  private

  def set_user_data
    @email = params[:email]
    @password = params[:password]
  end

  def authenticate_user
    redirect_to login_path, alert: "You must Log-in first" unless current_user
  end

end
