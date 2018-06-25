class SecurityQuestionsController < ApplicationController
    skip_before_action :authenticate_request, :only => [:get_security_questions,:validate_security_answers]
    
    #=GET /securityquestions
    #Retrieves the 3 security questions for a user associated with a given email address
    #===Errors:
    #* 400 Email parameter is missing
    #* 404 User doesn't exist with the given email in the database
    #===Params:
    #* email
    #   Must be a string and a valid email that exists in the database
    #===If Successful
    #* Response Code
    #   200
    #====Returns in JSON Format
    #* question1
    #   A string containing the first question registered to the user
    #* question2
    #   A string containing the second question registered to the user
    #* question3
    #   A string containign the third question registered to the user
    def get_security_questions
        if params.key?("email")
            sentEmail = params["email"]
            if User.exists?(:email => sentEmail)
                userID = User.find_by_Email(sentEmail)["Uid"]
                userFile = UserFile.find_by_Uid(userID)
                render json: {question1:userFile["Question1"],question2:userFile["Question2"],question3:userFile["Question3"]}, status: 200
            else
                render json: { error: "User not found"}, status: 404
            end
        else
            render json: { error: "Missing parameter 'email'"}, status: :bad_request
        end
    end

    #=POST /securityquestions
    #Takes the 3 security answers for a user and compares them against those in the database, setting their password to the new password if the answers are correct
    #===Errors:
    #* 400 Email parameter is missing
    #* 400 Answer 1 parameter is missing
    #* 400 Answer 2 parameter is missing
    #* 400 Answer 3 parameter is missing
    #* 400 New Password parameter is missing
    #* 400 Password Check parameter is missing
    #* 400 New Password and Password Check do not match
    #* 400 Password is an invalid format (does not meet the minimum password requirements)
    #* 404 User doesn't exist with the given email in the database
    #* 401 One or more of the answers do not match those in the database
    #===Params:
    #* email
    #   Must be a string and a valid email that exists in the database
    #* answer1
    #   Must be a string
    #* answer2
    #   Must be a string
    #* answer3
    #   Must be a string
    #* newpassword
    #   Must be a string that obeys the agreed password validation (At least 1 number and at least 8 characters long and at most 64)
    #* passwordcheck
    #   Must be a string that matches newpassword
     #===If Successful
    #* Response Code
    #   200
    #====Returns in JSON Format
    #* Nothing
    def validate_security_answers
        if params.key?("email") && params.key?("answer1") && params.key?("answer2") && params.key?("answer3") && params.key?("newpassword") && params.key?("passwordcheck")
            if User.exists?(:email => params["email"])
                if params["newpassword"] == params["passwordcheck"]
                    user = User.find_by_Email(params["email"])
                    userFile = UserFile.find_by_Uid(user["Uid"])
                   
                    if userFile["Answer1"] == params["answer1"] && userFile["Answer2"] == params["answer2"] && userFile["Answer3"] == params["answer3"]
                        if user.update(:password => params["newpassword"]) 
                            render status: 200
                        else
                            render json: {error: "Password is invalid"}, status: 400
                        end
                    else
                        render json: {error: "One or more of the answers are incorrect"}, status: 401
                    end
                else
                    render json: { error: "Passwords do not match"}, status: :bad_request
                end
            else
                render json: {error: "User doesn't exist"}, status: 404
            end
        else
            render json: {error: "Missing parameters"}, status: :bad_request
        end
    end
end
