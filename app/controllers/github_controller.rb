class GithubController < ApplicationController

  def authenticate
    redirect_uri = github_auth_callback_url
    scope = "gist"
    state = set_random_state

    redirect_to "https://github.com/login/oauth/authorize?client_id=#{client_id}&redirect_uri=#{redirect_uri}&scope=#{scope}&state=#{state}"
  end

  def callback
    if params[:state] == session[:state]
      get_access_token(params[:code])
      redirect_to wishlists_path, notice: "github hooked up!"
    else
      redirect_to wishlists_path, notice: "authorization failed"
    end
  end

  def create_gist
    url = "https://api.github.com/gists"
    hash = {"description" => params[:description], "public" => true, 
      "files" => {
        params[:title] => { "content" => params[:content] }
      }
    }

    response = HTTParty.post(url, { body: hash.to_json, headers: {"User-Agent" => "Class Auth App", "Authorization" => "token #{current_user.github_token}"}.to_json })
    redirect_to :back, notice: "gist created"
  end

  private

  def client_id
    @client_id ||= Rails.application.secrets.github_id
  end

  def get_access_token(code)
    begin
      client_secret ||= Rails.application.secrets.github_secret
      options = {client_id: client_id, client_secret: client_secret, code: code}
      response = HTTParty.post("https://github.com/login/oauth/access_token", body: options)
      token = parsed_response(response.parsed_response)
      current_user.github_token = token
      current_user.save!
    rescue
      raise
    end
  end

  def parsed_response(response)
    array1 = response.split('=')
    array2 = array1[1].split('&')
    array2[0]
  end

  def set_random_state
    session[:state] = Digest::SHA256.hexdigest("#{current_user.id}:#{SecureRandom.hex}")
  end

end