class UpdateinfoController < ApplicationController

	skip_before_action :authenticate_request

	def updateinfo
		#check the parameters
		if !is_params_present
			render json: {error: "Please enter email and password to confirm"}, status: :bad_request
			return
		end

		errors = false

		if !User.exists?(Email:params[:email])
			render json: {error: "User does not exists"}, status: :bad_request
			return
		end

		uid = User.find_by(Email: params[:email])["Uid"]
		userFile = UserFile.find_by(Uid: uid)



		if params.key?("FirstName")
      userFile.FirstName = params[:FirstName]
    end

    if params.key?("SurName")
      userFile.SurName = params[:SurName]
    end

    if params.key?("Company")
      userFile.Company = params[:Company]
    end

    if params.key?("JobTitle")
      userFile.JobTitle = params[:JobTitle]
    end

    if params.key?("WorkEmail")
      userFile.WorkEmail = params[:WorkEmail]
    end

    if params.key?("PhoneNum")
      userFile.PhoneNum = params[:PhoneNum]
    end


    if userFile.save
      render :nothing => true, status: :updated
    else
      messages = userFile.errors.full_messages
      render json: {error: messages}, status: :bad_request
    end


	end

	private
		def is_params_present
			params.key?("email") && params.key?("password")
		end

    def permit_params
      params.permit(:email, :password, :updateinfo)
    end

		def user_file_params
			params.permit(:FirstName, :SurName, :Company, :JobTitle, :WorkEmail,
				            :PhoneNum)
		end


end
