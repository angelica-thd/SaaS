class AuthenticationController < ApplicationController
  #POST auth\login
  #when authenticating a user we dont need a token -> only user valid_credentials
  #so no request authentication for that
  skip_before_action :authorize_request, only: :authenticate

  #before_action :authenticate, only: :destroy
  # return auth token once user is authenticated
   def authenticate
     user_auth = AuthenticateUser.new(auth_params[:email],auth_params[:password])
     auth_token = user_auth.call

     if user_auth.check_student != "student"
       response = {message: Message.simple,user: auth_params[:email], auth_token: auth_token}

     else
       response = {message: Message.student, user: auth_params[:email], auth_token: auth_token, student: user_auth.call_student }

     end
     json_response(response)
   end

  def destroy
    @curr = nil
    json_response(message: Message.logout)
  end



 private

 def auth_params
   params.permit(:email,:password)
 end

  def current
    @curr = AuthenticateUser.new(auth_params[:email],auth_params[:password]).curr_user
  end

end
