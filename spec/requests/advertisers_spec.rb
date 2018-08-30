require 'rails_helper'

RSpec.describe 'Advertiser API', type: :request do
  let(:advertiser) { build(:advertiser) }
  let(:headers) { valid_advertiser_headers.except('Authorization') }
  let(:valid_attributes) do
    {
      first_name: advertiser.first_name,
      last_name: advertiser.last_name,
      phone: advertiser.phone,
      address: advertiser.address,
      email: advertiser.email,
      password: advertiser.password,
      password_confirmation: advertiser.password
    } 
  end
  # User signup test suite
  describe 'POST advertiser/signup' do
    context 'when valid request' do
      before { post '/advertiser/signup', params: valid_attributes.to_json }

      it 'creates a new advertiser' do
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
      before { post '/advertiser/signup' }

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
