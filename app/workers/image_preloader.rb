class ImagePreloader
  @queue = :image_queue
  def self.perform(offset, refinery)
    response = HTTParty.get("https://openapi.etsy.com/v2/listings/active?keywords=wedding+#{ refinery }&limit=3&offset=#{ offset }&includes=Images&api_key=#{Rails.application.secrets.etsy_api_key}")
    response["results"]
  end
end