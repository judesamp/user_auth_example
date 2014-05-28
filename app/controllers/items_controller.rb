class ItemsController < ApplicationController

	def new
		@item = Item.new
	end

	def show
		@item = Item.find(params[:id])
		response = HTTParty.get("https://openapi.etsy.com/v2/listings/#{@item.etsy_id}/images?api_key=#{Rails.application.secrets.etsy_api_key}")
		@images = response["results"]
	end

	def create
		@item = Item.new(item_params)
		if @item.save
			client = TwitterOAuth::Client.new(
      		:consumer_key => Rails.application.secrets.twitter_key,
      		:consumer_secret => Rails.application.secrets.twitter_secret,
      		:token => current_user.twitter_token,
     	 		:secret => current_user.twitter_secret
    		)
	
    	client.update("Looking to buy me a present? I just added an item to a wishlist.")
			redirect_to wishlist_path(params[:wishlist_id]), notice: "Item added."
		else
			redirect_to :back, alert: "Failed to save."
		end
	end

	private

	def item_params
		params.require(:item).permit!
	end
end
