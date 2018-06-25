class UserinfoController < ApplicationController
  # skip_before_action :authenticate_request, :only => [:get_user_info]

  #=GET /user
  #Retrieves the file for a user associated with a given email address
  #===Errors:
  #* 401 Missing or invalid authentication token
  #* 400 Email parameter is missing
  #* 404 User doesn't exist with the given email in the database
  #===Params:
  #* email
  #   Must be a string and a valid email that exists in the database
  #===If Successful
  #* Response Code
  #   200
  #====Returns in JSON Format
  #* firstname
  #   A string containing the first name registered to the user
  #* surname
  #   A string containing the surname registered to the user
  #* company
  #   A string containing the company registered to the user
  #* jobtitle
  #   A string containing the job title registered to the user
  #* workemail
  #   A string containing the work email registered to the user
  #* phonenum
  #   A string containing the phone number registered to the user
  def get_user_info
    if !params.key?("email")
      render json: {error: "Missing parameter 'email'"}, status: :bad_request
    else
      begin
        @user = User.find_by! Email: params["email"]
        @user_file = UserFile.find_by! Uid: @user.Uid
        render json: {userid: @user.Uid, firstname: @user_file.FirstName, surname: @user_file.SurName, company: @user_file.Company, jobtitle: @user_file.JobTitle, workemail: @user_file.WorkEmail, phonenum: @user_file.PhoneNum,avatarid:@user_file.AvatarID}, status: 200
      rescue ActiveRecord::RecordNotFound => exception
        render json: {error: "User not found"}, status: 404
      end
    end
  end

   #=GET /user/token
  #Retrieves the file for a user associated with a given email address
  #===Errors:
  #* 400 Email parameter is missing
  #* 401 Missing or invalid authentication token
  #* 404 User doesn't exist with the given email in the database
  #===Params:
  #===If Successful
  #* Response Code
  #   200
  #====Returns in JSON Format
  #* firstname
  #   A string containing the first name registered to the user
  #* surname
  #   A string containing the surname registered to the user
  #* company
  #   A string containing the company registered to the user
  #* jobtitle
  #   A string containing the job title registered to the user
  #* workemail
  #   A string containing the work email registered to the user
  #* phonenum
  #   A string containing the phone number registered to the user
  def get_user_info_with_token
    decodedToken = JsonWebToken.decode(request.headers['Authorization'])
    userID = decodedToken["user_id"]
    @user_file = UserFile.find_by_Uid(userID)
    render json: {userid: userID, firstname: @user_file.FirstName, surname: @user_file.SurName, company: @user_file.Company, jobtitle: @user_file.JobTitle, workemail: @user_file.WorkEmail, phonenum: @user_file.PhoneNum,avatarid: @user_file.AvatarID}, status: 200
  end
end
