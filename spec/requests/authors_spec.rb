require 'rails_helper'

RSpec.describe 'Author API', type: :request do
  let(:author) { build(:author) }
  let(:headers) { valid_author_headers.except('Authorization') }
  let(:valid_attributes) do
    attributes_for(:author, password_confirmation: author.password)
  end

  # Author signup test suite
  describe 'POST author/signup' do
    context 'when valid request' do
      before { post '/author/signup', params: valid_attributes.to_json, headers: headers }

      it 'creates a new author' do
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
      before { post '/author/signup', params: {}, headers: headers }

      it 'does not create a new advertiser' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json['message'])
          .to match(/Validation failed: Password can't be blank, First Name can't be blank, Last Name can't be blank, Phone Name can't be blank, Address can't be blank, Email can't be blank, Password digest can't be blank/)
      end
    end
  end
end
