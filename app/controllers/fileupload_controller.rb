class FileuploadController < ApplicationController
	skip_before_action :authenticate_request

	def upload_file
		# check presence
		if is_params_present && is_request_valid
			# create a record
			f = FileList.new
			f.file = get_tempfie
			f.Mid = get_mid
			
			# save the record (save the file)
			if	f.save!
				# convert to images
				pdf_to_image(f)
				# remove the original pdf and the record
				f.remove_file!
				f.destroy
				render status: :ok
			else
				render status: :bad_request
			end
		else
			render status: :bad_request
		end
	end

	def downloadapk
		send_file 'vrmeeting.apk'
	end
	
	private
		def pdf_to_image(f)
			# convert pdf to jpg in windows using imagemagick
			file_path = f.file.path
			file_name = File.basename(file_path, ".*")
			file_dir = File.dirname(file_path)
			system "magick convert -density 150 " + file_path + " -quality 100 " + file_dir + "/%d.jpg"
		end
		
		def is_params_present
			params.key?("mid") && params.key?("uploaded_file")
		end
		
		def is_request_valid
			request.form_data? && request.headers[:Authorization]
		end
		
		def get_tempfie
			params[:uploaded_file].tempfile
		end
		
		def get_uid	
			JsonWebToken.decode(request.headers[:Authorization])
		end
		
		def get_mid
			params[:mid]
		end
end
