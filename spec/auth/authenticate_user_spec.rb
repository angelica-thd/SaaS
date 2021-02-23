require 'rails_helper'

RSpec.describe AuthenticateUser do
  # create test user
  let(:user) { create(:user) }
  # valid request subject
  subject(:valid_auth_obj) { described_class.new(user.email, user.password) }
  # invalid request subject
  subject(:invalid_auth_obj) { described_class.new('foo', 'bar') }

  # Test suite for AuthenticateUser#call
  describe '#call' do
    # return token when valid request
    context 'when valid credentials' do
      it 'returns an auth token' do
        token = valid_auth_obj.call
        expect(token).not_to be_nil
      end
    end

    # raise Authentication Error when invalid request
    context 'when invalid credentials' do
      it 'raises an authentication error' do
        expect { invalid_auth_obj.call }
          .to raise_error(
            ExceptionHandler::AuthenticationError,
            /Invalid credentials/
          )
      end
    end
  end
  describe '#call_student' do
    # return token and student obj when valid request
    context 'when valid credentials' do
      it 'returns an auth token and student info' do
        token = valid_auth_obj.call
        student = valid_auth_obj.check_student
        expect(token).not_to be_nil
        expect(student).not_to be_nil
      end
    end

    # raise Authentication Error when invalid request
    context 'when invalid credentials' do
      it 'raises an authentication error' do
        expect { invalid_auth_obj.call or invalid_auth_obj.check_student}
          .to raise_error(
                ExceptionHandler::AuthenticationError,
                /Invalid credentials/
              )
      end
    end
  end
end
