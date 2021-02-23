class AuthenticateUser
  def initialize(email,password)
    @email = email
    @password = password
  end
  
  def call  #generates authentication token for user
    JsonWebToken.encode(user_id: user.id) if user
  end

  def curr_user #shows user credentials
    user
  end

  def check_student #checks if user is student
    if student != "admin"
      "student"
    end
  end

  def call_student #shows student's info
    student
  end



  private

  attr_reader :email, :password

  # verify user credentials
  def user
    user = User.find_by(email: email)
    return user if user && user.authenticate(password)
    # raise Authentication error if credentials are invalid
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end

  def student
    stud = User.find_by(email: email)
    if user
      if stud.students!= []
        return stud.students.first
      else
        return "admin"
       end
    end
  end

end
