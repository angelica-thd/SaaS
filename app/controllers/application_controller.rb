class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  # called before every action on controllers
  #before any action is made -> authorize the user
  #if user is authorized -> current user is set and can be used by the other controllers
  before_action :authorize_request
  attr_reader :current_user

  private

  # Check for valid request token and return user
  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end
end
