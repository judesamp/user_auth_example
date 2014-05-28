require 'twitter'

class TwitterController < ApplicationController

  def authenticate
    @client = TwitterOAuth::Client.new(
      :consumer_key => Rails.application.secrets.twitter_key,
      :consumer_secret => Rails.application.secrets.twitter_secret,
      :access_token => Rails.application.secrets.twitter_token,
      :access_token_secret => Rails.application.secrets.twitter_token_secret

    )

    @request_token = @client.request_token(:oauth_callback => twitter_auth_callback_url)
    my_url = @request_token.authorize_url
    session[:secret] = @request_token.secret
    redirect_to my_url   
  end

  def callback

    @client = TwitterOAuth::Client.new(
      :consumer_key => Rails.application.secrets.twitter_key,
      :consumer_secret => Rails.application.secrets.twitter_secret,
      :access_token => Rails.application.secrets.twitter_token,
      :access_token_secret => Rails.application.secrets.twitter_token_secret
    )

    access_token = @client.authorize(
      params[:oauth_token],
      session[:secret],
      :oauth_verifier => params[:oauth_verifier]  
    )

    # @client.update('checking out the twitter_oauth library')

    current_user.twitter_token = access_token.token
    current_user.twitter_secret = access_token.secret
    current_user.save!

    redirect_to wishlists_path, notice: "Twitter Authorized!"
  end

  private

  # def get_access_token(code)
  #   begin
  #     client_secret ||= Rails.application.secrets.twitter_secret
  #     options = {client_id: client_id, client_secret: client_secret, code: code}
  #     response = HTTParty.post("https://github.com/login/oauth/access_token", body: options)
  #     token = parsed_response(response.parsed_response)
  #     current_user.github_token = token
  #     current_user.save!
  #   rescue
  #     raise
  #   end
  # end

end

