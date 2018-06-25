class DeleteController < ApplicationController
  	skip_before_action :authenticate_request, :only => [:deleteuser]

  	def deleteuser

      if !params.key?("Email")
        render json: {error: "email address not specified"}, status: :bad_request
      end

  		if !is_DBconnected
  			render json: {error: "Failed to connect to database!"}, status: :internal_server_error
  			return
  		end


  		errors = false

      if User.exists?(Email:params[:Email])
        user = User.find_by_Email(params[:Email])
        user.destroy
        render json: {message: "user account deleted"}, status: :ok

			else
        error = true
      end

  		if(errors)
        render json: {error: "email address not found"}, status: :no_content
  		end
  	end


  	private

  		def is_DBconnected
  			begin
  				ActiveRecord::Base.connection_pool.with_connection {|con| con.active?}
  				return true
  			rescue => err
  				return false
  			end
  		end

end
