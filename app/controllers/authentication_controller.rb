class AuthenticationController < ApplicationController
	skip_before_action :authenticate_request, :only => [:authenticate]
	
	def is_token_valid
		render status: :ok
	end

	def authenticate

		if !params.key?("email") || !params.key?("password")
			render json: {error: "Invalid username or password"}, status: :unauthorized
		else
			command = AuthenticateUser.call(params[:email],params[:password])

			if command.success?
				render json: { auth_token: command.result }
			else
				render json: { error: command.errors }, status: :unauthorized
			end
			
		end
	end
end
