class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :ensure_logged_in

  helper_method :current_user


  def client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_key
      config.consumer_secret     = Rails.application.secrets.twitter_secret
      config.access_token        = Rails.application.secrets.twitter_token
      config.access_token_secret = Rails.application.secrets.twitter_token_secret
    end
  end

  def ensure_logged_in
  	if current_user.nil?
  		redirect_to login_path
  	end
  end

  private

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end



end
