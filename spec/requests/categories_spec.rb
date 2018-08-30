require 'rails_helper'

RSpec.describe 'Categories API', type: :request do
  # initialize test data
  let!(:categories) { create_list(:category, 10) }
  let(:category_id) { categories.first.id }
  let!(:author) { create(:author) }
  let(:headers) { valid_author_headers }
  # Test suite for GET /Listings
  describe 'GET /categories' do
    before { get '/categories', params: {}, headers: headers }

    it "returns categories" do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

# Test suit for show action
  describe 'GET /categories/:id' do
    before { get "/categories/#{category_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it "returns a categories" do
        expect(json).not_to be_empty
        expect(json['id']).to eq(category_id)
      end
      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end
    context 'when the record does not exist' do
      let(:category_id) { 100 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/"Couldn't find Category with 'id'=100\"/)
      end
    end
  end

  # Test duite for POST /listings
  describe 'POST /categories' do
    #valid payload
    let(:valid_attributes) {{ category_name: 'Kitchen' }}.to_json
    context 'when the request is valid' do
      before { post '/categories', params: valid_attributes, headers: headers  }

      it "creates a category" do
        expect(json['category_name']).to eq('Kitchen')
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/categories', params:{ category_name: '' }, headers: headers }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end

      it "returns a validation failure message" do
        expect(response.body).to match(/Validation failed: Category name can't be blank/)
      end
    end
  end

  # test suite for PUT /listings/:id
  describe 'PUT /categories/:id' do
    let(:valid_attributes) { { category_name: 'Shopping' } }

    context 'when the record exists' do
      before { put "/categories/#{category_id}", params:valid_attributes, headers: headers }

      it "updates the record" do
        expect(response.body).to be_empty
      end

      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for Delete /listings/:id

  describe 'DELETE /categories/:id' do
    before { delete "/categories/#{category_id}", headers: headers }

    it "returns status code 204" do
      expect(response).to have_http_status(204)
    end
  end
end
