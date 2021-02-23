require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let(:user) { build(:user) }
  let(:headers) { valid_headers.except('Authorization') }
  let(:valid_attributes) do
    attributes_for(:user, password_confirmation: user.password)
  end

  # User signup test suite
  describe 'POST /signup' do
    context 'when valid request' do
      before { post '/signup', params: valid_attributes.to_json, headers: headers }

      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end

      it 'returns success message' do
        expect(json['message']).to match(/Account created successfully/)
      end

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'when invalid request' do
      before { post '/signup', params: {}, headers: headers }

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json['message'])
          .to match(/Validation failed: Password can't be blank, Name can't be blank, Email can't be blank, Password digest can't be blank/)
      end
    end
  end

  # User update test suite
  describe 'PUT /update' do
    context 'when valid request' do
      before { put '/update', params: valid_attributes.to_json, headers: headers }

      it 'updates the current user' do
        expect(response).to have_http_status(201)
      end

      it 'returns success message' do
        expect(json['message']).to match(/User updated successfully./)
      end

      it 'returns the updated user' do
        expect(json['new_credentials']).not_to be_nil
      end
    end

    context 'when invalid request' do
      before { put '/update', params: {}, headers: headers }

      it 'does not update the user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json['message'])
          .to match(/Validation failed: Authorization shouldn't be blank /)
      end
    end
  end

  # User destroy test suite
  describe 'DELETE /delete' do
    context 'when valid request' do
      before { delete '/delete', params: valid_attributes.to_json, headers: headers }

      it 'deletes the current user' do
        expect(response).to have_http_status(201)
      end

      it 'returns success message' do
        expect(json['message']).to match(/User deleted successfully./)
      end

    end

    context 'when invalid request' do
      before { delete '/delete', params: {}, headers: headers }

      it 'does not delete the user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json['message'])
          .to match(/Validation failed: Authorization shouldn't be blank /)
      end
    end
  end

  # User me test suite
  describe 'POST /me' do
    context 'when valid request' do
      before { post '/me', params: valid_attributes.to_json, headers: headers }

      it 'returns the current user info' do
        expect(response).to have_http_status(201)
      end

      it 'returns the type of user' do
        expect(json['user']).not_to be_nil
      end

    end

    context 'when invalid request' do
      before { post '/me', params: {}, headers: headers }

      it 'does not return the user info' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json['message'])
          .to match(/Validation failed: Authorization shouldn't be blank /)
      end
    end
  end
end
