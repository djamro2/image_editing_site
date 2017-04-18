class GifReverserController < ApplicationController

	# turn off CSRF
	protect_from_forgery with: :null_session
	
	def index
	end

	def reverse_gif
		gif_url = params[:gif_url]
		puts "Passed in gif url: #{gif_url}"
		msg = {:response => "OK"}
		render :json => msg
	end

end
