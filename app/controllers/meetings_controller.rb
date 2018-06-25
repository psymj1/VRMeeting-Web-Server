class MeetingsController < ApplicationController

  require 'securerandom'
  skip_before_action :authenticate_request, :only => [:createmeeting,:get_presenter_id]

  def createmeeting

    #check the parameters
    if !is_meeting_params_present
      render json: {error: "Parameters lost!"}, status: :bad_request
      return
    end

    if Meeting.exists?(MeetingName: params["MeetingName"])
      render json: {error: "MeetingName exists!"}, status: :bad_request
      return
    end

    decodedToken = JsonWebToken.decode(request.headers['Authorization'])
    userID = decodedToken["user_id"]

    newMeeting = Meeting.new(meeting_params)
    newMeeting["Uid"] = userID
    mCode = SecureRandom.hex(4)
    newMeeting["MeetingCode"] = mCode


    if newMeeting.save
      render json: {meeting_code: mCode}, status: :created
    else
      error = meeting.errors.full_messages
      Meeting.delete(newMeeting["Mid"])
			render json: {error: error}, status: :bad_request
    end

  end

  #=GET /meeting/presenter
    #Retrieves the presenter id for the given meeting code. Used on the host server to determine if a user is the presenter
    #===Errors:
    #* 400 Missing Parameter mcode
    #* 404 Meeting Code does not exist
    #===Params:
    #* mcode
    #   The meeting code for the meeting to get the presenter of
    #===If Successful
    #* Response Code
    #   200
    #====Returns in JSON Format
    #* pid
    #  An integer representing the UID of the presenter of the meeting
  def get_presenter_id
    if !params.key?("MeetingCode")
      render json: {error: "Missing parameters"}, status: :bad_request
      return
    end

    if !Meeting.exists?(MeetingCode: params["MeetingCode"])
      render json: {error: "Meeting Code not found"}, status: 404
      return
    end

    meeting = Meeting.find_by_MeetingCode(params["MeetingCode"])
    presenter_id = meeting["Uid"]
    render json: {presenter_id:presenter_id}, status: 200
  end

  def joinmeeting

    ##check mCode whether it exists
    ##return ip and port

    #check the parameters
    if !is_join_params_present
      render json: {error: "Please enter meeting code"}, status: :bad_request
      return
    end


    if Meeting.exists?(MeetingCode: params["mCode"])
      render json: {hIP: "192.168.1.111", hPort: "25566",fIP: "192.168.1.111",fPort: "8080"}, status: :ok
    else
      render json: {error: "Can't find match. Please check again."}, status: :bad_request
      return
    end

  end

  private
		def is_meeting_params_present
		 params.key?("MeetingName")
		end

    def meeting_params
      params.permit(:MeetingName, :DoM, :ToM, :MeetingDescption)
    end


    def is_join_params_present
      params.key?("mCode")
    end

    def join_params
      param.permit(:mCode)
    end

end
