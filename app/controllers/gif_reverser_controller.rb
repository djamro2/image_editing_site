
# good test image to use for reversing:
# https://i.redd.it/0vbby789bcsy.gif

require "open-uri"
require "securerandom"

def delete_file(filename)

end

def download_gif(url, name="output")
	open(url) { |f|

		# determine file extension, complete name
		file_extension = ".gif"
		if f.content_type == "image/gif"
			file_extension = ".gif"
		end
		filename = name + file_extension

		# open and write
	    File.open(filename, "wb") do |file|
	    	file.puts f.read
	    end

	    return file_extension
	}
end

def get_random_string
	return SecureRandom.urlsafe_base64 8
end

def run_reverse_command(raw_name, file_extension)
	filename_normal = raw_name + file_extension
	filename_reversed = raw_name + "_reversed" + file_extension
	system "convert #{filename_normal} -coalesce -reverse  -quiet -layers OptimizePlus  -loop 0 #{filename_reversed}"
end

def validate_url(gif_url)
	if not (gif_url.index('.com') or gif_url.index('.it'))
		return nil
	end
	if gif_url.index('.gifv')
		return nil
	end
	return true
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
			error_msg = {:message => "Invalide gif url"}
			render :status => 500, :json => error_msg and return
		end

		# used for saving locally w/o name conflicts
		raw_name = get_random_string

		# download gif from url
		file_extension = download_gif(gif_url, raw_name)

		# run command line to reverse downloaded file
		run_reverse_command raw_name, file_extension

		# upload to S3

		# delete the file

		# return message
		msg = {:response => "OK"}
		render :json => msg
	end

end
