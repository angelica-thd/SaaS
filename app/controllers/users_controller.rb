class UsersController < ApplicationController
  # POST /signup
  #when signing up a user we dont need a token -> only user valid_credentials
  #so no request authentication for that
  skip_before_action :authorize_request, only: :create

  # return authenticated token upon signup
  def create
    user = User.create!(user_params)  #create! in case of an error  the exception will be handled instead of failing and returning 'false'
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end


  def update
    @current_user.update(user_params)
    response = {message: Message.simple_update,new_credentials: @current_user }
    json_response(response)
  end

  def destroy
    @current_user.destroy
    json_response(message: Message.simple_destroy)
  end

  def me
    if @current_user.students!=[]
      response = {user: Message.student,credentials: @current_user, student_info: @current_user.students.first}
    else
      response = {user: Message.simple, credentials: @current_user}
    end
    json_response(response)
  end



  private

  def user_params
    params.permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end

end
