class WishlistsController < ApplicationController

	def index
		@wishlists = current_user.wishlists.all 
	end

	def show
		@wishlist = Wishlist.find(params[:id])
	end

	def create
		@wishlist = current_user.wishlists.build(wishlist_params)
		if @wishlist.save
		 	client = TwitterOAuth::Client.new(
    		:consumer_key => Rails.application.secrets.twitter_key,
    		:consumer_secret => Rails.application.secrets.twitter_secret,
    		:token => current_user.twitter_token,
   	 		:secret => current_user.twitter_secret
  		)
	
    	client.update("I just added a new wishlist. I'm calling it #{@wishlist.name}")

			redirect_to :back, notice: "Wishlist added."
		else
			redirect_to :back, alert: "Failed to save."
		end
	end

	private

	def wishlist_params
		params.require(:wishlist).permit!
	end
end
