class ListingsController < ApplicationController

  def index
    $redis.set("images", ImagePreloader.perform(3, "invitations").to_json)
    @invitations = listing_etsy_request("invitations")
    @favors = listing_etsy_request("favors")
    @ties = listing_etsy_request("ties")
    @flowers = listing_etsy_request("flowers")
    @accessories = listing_etsy_request("accessories")
    @garters = listing_etsy_request("garters")
    @teams = HTTParty.get("https://openapi.etsy.com/v2/teams?keywords=wedding&limit=3&api_key=#{Rails.application.secrets.etsy_api_key}")["results"]
  end

  def listing_etsy_request(refinery)
    response = HTTParty.get("https://openapi.etsy.com/v2/listings/active?keywords=wedding+#{refinery}&limit=3&includes=Images&api_key=#{Rails.application.secrets.etsy_api_key}")
    response["results"]
  end

  def etsy_offset_request(offset, refinery)
    response = HTTParty.get("https://openapi.etsy.com/v2/listings/active?keywords=wedding+#{ refinery }&limit=3&offset=#{ offset }&includes=Images&api_key=#{Rails.application.secrets.etsy_api_key}")
    response["results"]
  end

  def apply_offset(offset)
    offset + 3
  end

  def invitations
    @offset = apply_offset(params[:offset].to_i)
    @invitations = JSON.parse($redis.get('images'))
    $redis.set("images", ImagePreloader.perform(@offset, "invitations").to_json)
    respond_to do |format|
      format.js {}
    end
  end

  def favors
    offset = apply_offset(params[:offset].to_i)
    @favors = etsy_offset_request(offset, "favors")

    respond_to do |format|
      format.js {}
    end
  end

  def ties
    offset = apply_offset(params[:offset].to_i)
    @ties =  etsy_offset_request(offset, "ties")

    respond_to do |format|
      format.js {}
    end
  end

  def flowers
    offset = apply_offset(params[:offset].to_i)
    @flowers = etsy_offset_request(offset, "flowers")

    respond_to do |format|
      format.js {}
    end
  end

  def accessories
    offset = apply_offset(params[:offset].to_i)
    @accessories = etsy_offset_request(offset, "accessories")

    respond_to do |format|
      format.js {}
    end
  end

  def garters
    offset = apply_offset(params[:offset].to_i)
    @garters = etsy_offset_request(offset, "garters")
    
    respond_to do |format|
      format.js {}
    end
  end
end
