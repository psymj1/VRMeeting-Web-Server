class RegistrationController < ApplicationController
	skip_before_action :authenticate_request, :only => [:register,:email_exists]

	def register
		#check the parameters
		if !is_params_present
			render json: {error: "Parameters lost!"}, status: :bad_request
			return
		end
		
		if !is_password_match
			render json: {error: "Password does not match!"}, status: :bad_request
			return
		end
		
		if !is_DBconnected
			render json: {error: "Failed to connect to database!"}, status: :internal_server_error
			return
		end

		# #create and save new model objects
		errors = false

		user = User.new(login_params)
		user_file = UserFile.new(user_file_params)

		if user.save
			userID = User.find_by_Email(user["Email"])["Uid"]
			user_file["Uid"] = userID
			 if user_file.save
				render :nothing => true, status: :created
			 else
				User.delete(userID)
				errors = true
			 end
		else
			errors = true
		end

		if(errors)
			messages = user.errors.full_messages
			messages += user_file.errors.full_messages
			render json: {error: messages}, status: :bad_request
		end
	end

	def email_exists
		if params.key?("email")
			if User.exists?(Email:params["email"])
				render :nothing => true, status: :ok
			else
				render :nothing => true, status: 404
			end
		else
			render :nothing => true, status: :bad_request
		end
	end
	
	private
		def is_params_present
			params.key?("Email") && params.key?("password") && params.key?("passwordcheck") && params.key?("FirstName") && params.key?("SurName") && params.key?("Company") && params.key?("JobTitle") && params.key?("Question1") && params.key?("Question2") && params.key?("Question3") && params.key?("Answer1") && params.key?("Answer2") && params.key?("Answer3") && params.key?("AvatarID")
		end

		def is_password_match
			login_params[:password] == params.permit(:passwordcheck)[:passwordcheck]
		end 
				
		def is_DBconnected
			begin
				ActiveRecord::Base.connection_pool.with_connection {|con| con.active?}
				return true
			rescue => err
				return false
			end
		end
		
		def login_params
			#the form of data?
			params.permit(:Email, :password)
		end
		
		def user_file_params
			params.permit(:FirstName, :SurName, :Company, :JobTitle, :WorkEmail, :PhoneNum, :Question1, :Question2, :Question3, :Answer1, :Answer2, :Answer3,:AvatarID)
		end
end
