class AuthenticationController < ApplicationController
  #POST auth\login
  #when authenticating a user we dont need a token -> only user valid_credentials
  #so no request authentication for that
  skip_before_action :authorize_request, only: :authenticate
  # return auth token once user is authenticated
 def authenticate
   auth_token =
     AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
   json_response(auth_token: auth_token)
 end

 private

 def auth_params
   params.permit(:email, :password)
 end
end
