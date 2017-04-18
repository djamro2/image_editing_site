
require "open-uri"

def download_gif(url)
	open(url) {|f|
		puts f.content_type
	    File.open("whatever_file.gif","wb") do |file|
	    	file.puts f.read
	    end
	}
end

def run_command()
	puts `echo hello world`
end

def validate_url(gif_url)
	return gif_url.index('.com')
end

class GifReverserController < ApplicationController

	# turn off CSRF
	protect_from_forgery with: :null_session
	
	def index
	end

	def reverse_gif

		# get gif_url and validate
		gif_url = params[:gif_url]
		if not validate_url(gif_url)
			error_msg = {:message => "Invalide url"}
			render :status => 500, :json => error_msg and return
		end

		# download gif from url
		download_gif(gif_url)

		# run command line to reverse downloaded file
		run_command()

		# return message
		msg = {:response => "OK"}
		render :json => msg
	end

end
