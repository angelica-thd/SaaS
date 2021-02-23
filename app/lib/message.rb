class Message
  def self.not_found(record = 'record')
    "Sorry, #{record} not found."
  end

  def self.invalid_credentials
    'Invalid credentials'
  end

  def self.invalid_token
    'Invalid token'
  end

  def self.missing_token
    'Missing token'
  end

  def self.unauthorized
    'Unauthorized request'
  end

  def self.account_created
    'Account created successfully'
  end

  def self.student_created
    'Student created successfully'
  end

  def self.account_not_created
    'Account could not be created'
  end

  def self.simple
    'Simple user'
  end
  def self.student
    'Student user'
  end

  def self.logout
    'Logged out successfully.'
  end

  def self.simple_update
    'User updated successfully.'
  end

  def self.student_update
    'Student updated successfully.'
  end

  def self.simple_destroy
    'User deleted successfully.'
  end

  def self.student_destroy
    'Student deleted successfully.'
  end

  def self.expired_token
    'Sorry, your token has expired. Please login to continue.'
  end
end
