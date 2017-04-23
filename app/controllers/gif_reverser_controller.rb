
# good test image to use for reversing:
# https://i.redd.it/0vbby789bcsy.gif

require "open-uri"
require "securerandom"

def change_gif_url(gif_url)
	if gif_url.index('.gifv')
		return gif_url[0..gif_url.length-2]
	end
	return gif_url
end

def download_gif(url, name="output", file_extension=".gif")
	open(url) { |f|
		filename = name + file_extension
	    File.open(filename, "wb") do |file|
	    	file.puts f.read
	    end

	    return file_extension
	}
end

def get_random_string
	return SecureRandom.urlsafe_base64 8
end

def get_s3_url(raw_name, file_extension=".gif")
	return "https://s3.amazonaws.com/image-editor-site/reversed_gifs/#{raw_name}_reversed#{file_extension}"
end

def run_reverse_command(raw_name, file_extension=".gif")
	filename_normal = raw_name + file_extension
	filename_reversed = raw_name + "_reversed" + file_extension
	system "convert #{filename_normal} -coalesce -reverse -quiet -layers OptimizePlus -loop 0 #{filename_reversed} && rm #{filename_normal}"
end

def upload_to_s3(raw_name, file_extension=".gif")
	filename_reversed = raw_name + "_reversed" + file_extension
	system "aws s3 mv #{filename_reversed} s3://image-editor-site/reversed_gifs/#{filename_reversed}"
end

def validate_url(gif_url)
	g = gif_url

	# if the gif has .gifv, make sure its from imgur
	if g[g.length-5..g.length-1] == ".gifv" and g.index('imgur')
		return true
	elsif g.index('.gifv')
		return false
	end
		
	# otherwise, needs to have '.gif'
	if g[g.length-4..g.length-1] == ".gif"
		return true
	end

	return false
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
			error_msg = {:message => "Invalide gif url (gif needs to end in .gif or .gifv)"}
			render :status => 500, :json => error_msg and return
		end
		gif_url = change_gif_url gif_url

		# see if we already reversed this gif
		previouslyReversed = ReversedGif.find_by source_url: gif_url
		if previouslyReversed and previouslyReversed[:status] == "done"
			msg = {:response => "OK", 
				   :raw_name => previouslyReversed[:raw_name], 
				   :url => previouslyReversed[:reversed_url]}
			render :json => msg and return
		end

		# used for saving locally w/o name conflicts
		raw_name = get_random_string

		# save in database
		reversedGif = ReversedGif.new(source_url: gif_url, raw_name: raw_name)
		reversedGif.save()

		# download gif from url
		download_gif(gif_url, raw_name)

		# run command line to reverse downloaded file
		run_reverse_command raw_name

		# upload to S3
		upload_to_s3 raw_name

		# update the row created in the database
		reversedGif.status = "done"
		reversedGif.reversed_url = get_s3_url(raw_name)
		reversedGif.save

		# return message
		msg = {:response => "OK", :raw_name => raw_name, :url => get_s3_url(raw_name)}
		render :json => msg
	end

end
