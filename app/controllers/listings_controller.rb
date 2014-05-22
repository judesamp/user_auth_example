class ListingsController < ApplicationController

  def index
    invitations = HTTParty.get("https://openapi.etsy.com/v2/listings/active?keywords=wedding+invitations&limit=3&includes=Images&api_key=#{Rails.application.secrets.etsy_api_key}")
    @invitations = invitations["results"]

    teams = HTTParty.get("https://openapi.etsy.com/v2/teams?keywords=wedding&limit=3&api_key=#{Rails.application.secrets.etsy_api_key}")
    @teams = teams["results"]

    favors = HTTParty.get("https://openapi.etsy.com/v2/listings/active?keywords=wedding+favors&limit=3&includes=Images&api_key=#{Rails.application.secrets.etsy_api_key}")
    @favors = favors["results"]

    ties = HTTParty.get("https://openapi.etsy.com/v2/listings/active?keywords=wedding+ties&limit=3&includes=Images&api_key=#{Rails.application.secrets.etsy_api_key}")
    @ties =  ties["results"]

    flowers = HTTParty.get("https://openapi.etsy.com/v2/listings/active?keywords=wedding+flowers&limit=3&includes=Images&api_key=#{Rails.application.secrets.etsy_api_key}")
    @flowers = flowers["results"]  

    accessories = HTTParty.get("https://openapi.etsy.com/v2/listings/active?keywords=wedding+accessories&limit=3&includes=Images&api_key=#{Rails.application.secrets.etsy_api_key}")
    @accessories = accessories["results"]

    garters = HTTParty.get("https://openapi.etsy.com/v2/listings/active?keywords=wedding+garters&limit=3&includes=Images&api_key=#{Rails.application.secrets.etsy_api_key}")
    @garters = garters["results"]
  end

  def invitations
    @offset = params[:offset].to_i
    @offset += 3
    invitations = HTTParty.get("https://openapi.etsy.com/v2/listings/active?keywords=wedding+invitations&limit=3&offset=#{ @offset }&includes=Images&api_key=#{Rails.application.secrets.etsy_api_key}")
    @invitations = invitations["results"]

    respond_to do |format|
      format.js {}
    end
  end

  def favors
    @offset = params[:offset].to_i
    @offset += 3

    favors = HTTParty.get("https://openapi.etsy.com/v2/listings/active?keywords=wedding+favors&limit=3&offset=#{ @offset }&includes=Images&api_key=#{Rails.application.secrets.etsy_api_key}")
    @favors = favors["results"]

    respond_to do |format|
      format.js {}
    end
  end

  def ties
    @offset = params[:offset].to_i
    @offset += 3

    ties = HTTParty.get("https://openapi.etsy.com/v2/listings/active?keywords=wedding+ties&limit=3&offset=#{ @offset }&includes=Images&api_key=#{Rails.application.secrets.etsy_api_key}")
    @ties =  ties["results"]
    respond_to do |format|
      format.js {}
    end
  end

  def flowers
    @offset = params[:offset].to_i
    @offset += 3

    flowers = HTTParty.get("https://openapi.etsy.com/v2/listings/active?keywords=wedding+flowers&limit=3&offset=#{ @offset }&includes=Images&api_key=#{Rails.application.secrets.etsy_api_key}")
    @flowers = flowers["results"]

    respond_to do |format|
      format.js {}
    end
  end

  def accessories
    @offset = params[:offset].to_i
    @offset += 3

    accessories = HTTParty.get("https://openapi.etsy.com/v2/listings/active?keywords=wedding+accessories&limit=3&offset=#{ @offset }&includes=Images&api_key=#{Rails.application.secrets.etsy_api_key}")
    @accessories = accessories["results"]

    respond_to do |format|
      format.js {}
    end
  end

  def garters
    @offset = params[:offset].to_i
    @offset += 3

    garters = HTTParty.get("https://openapi.etsy.com/v2/listings/active?keywords=wedding+garters&limit=3&offset=#{ @offset }&includes=Images&api_key=#{Rails.application.secrets.etsy_api_key}")
    @garters = garters["results"]
    
    respond_to do |format|
      format.js {}
    end
  end
end
