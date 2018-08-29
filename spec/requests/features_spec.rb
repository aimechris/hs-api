require 'rails_helper'

RSpec.describe 'Features API', type: :request do
  # initialize test data
  let!(:features) { create_list(:feature, 10) }
  let(:feature_id) { features.first.id }
  let!(:advertiser) { create(:advertiser) }
  let(:headers) { valid_advertiser_headers }
  # Test suite for GET /features
  describe 'GET /features' do
    before { get '/features', params: {}, headers: headers }

    it "returns features" do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  # Test suit for show action
  describe 'GET /features/:id' do
    before { get "/features/#{feature_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it "returns a feature" do
        expect(json).not_to be_empty
        expect(json['id']).to eq(feature_id)
      end
      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end
    context 'when the record does not exist' do
      let(:feature_id) { 100 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/"Couldn't find Feature with 'id'=100\"/)
      end
    end
  end

  # Test duite for POST /listings
  describe 'POST /features' do
    #valid payload
    let(:valid_attributes) { { feature_name: 'Kitchen' } }
    context 'when the request is valid' do
      before { post '/features', params: valid_attributes, headers: headers }

      it "creates a feature" do
        expect(json['feature_name']).to eq('Kitchen')
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/features', params:{ feature_name: 'qet' }, headers: headers }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end

      it "returns a validation failure message" do
        expect(response.body).to match(/Validation failed: feature_name can't be blank\"/)
      end
    end
  end

  # test suite for PUT /listings/:id
  describe 'PUT /features/:id' do
    let(:valid_attributes) { { feature_name: 'Air Condition' } }

    context 'when the record exists' do
      before { put "/features/#{feature_id}", params:valid_attributes, headers: headers }

      it "updates the record" do
        expect(response.body).to be_empty
      end

      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for Delete /listings/:id

  describe 'DELETE /features/:id' do
    before { delete "/features/#{feature_id}", headers: headers }

    it "returns status code 204" do
      expect(response).to have_http_status(204)
    end
  end
end
