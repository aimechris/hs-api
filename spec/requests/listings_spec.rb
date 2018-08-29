require 'rails_helper'

RSpec.describe 'Listings API', type: :request do
  # initialize test data
  let!(:listings) { create_list(:listing, 10) }
  let(:listing_id) { listings.first.id }
  let!(:advertiser) { create(:advertiser) }
  let(:headers) { valid_advertiser_headers }
  # Test suite for GET /Listings
  describe 'GET /listings' do
    before { get '/listings', params: {}, headers: headers }

    it "returns listings" do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /search
  describe 'GET /search' do
    let(:search_params) { { sales: 'Buy', city: 'new york' } }
    before { get '/search', params: search_params, headers: headers  }

    context 'When searched results found' do
      it "returns listings" do
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the search record doesn't exists" do
      let!(:listings) { create_list(:listing, 0) }

      it "retuns empty listings" do
        expect(json).to be_empty
      end
      it "returns a no content message" do
        expect(response.body).to match('[]')
      end
    end
  end

  # Test suite for GET /filter
  describe 'GET /filter' do
    # valid attribute
    let(:filter_params) { { sales: 'Buy', city: 'new york', min_price: '500', max_price:'1500', bed:'4', bath:'2' } }
    before { get '/filter', params: filter_params, headers: headers  }

    context 'When searched results found' do
      it "returns listings" do
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the search record doesn't exists" do
      let!(:listings) { create_list(:listing, 0) }

      it "retuns empty listings" do
        expect(json).to be_empty
      end
      it "returns a no content message" do
        expect(response.body).to match('[]')
      end
    end
  end

  # Test suit for show action
  describe 'GET /listings/:id' do
    before { get "/listings/#{listing_id}", headers: headers  }

    context 'when the record exists' do
      it "returns a listing" do
        expect(json).not_to be_empty
        expect(json['id']).to eq(listing_id)
      end
      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end
    context 'when the record does not exist' do
      let(:listing_id) { 100 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/"Couldn't find Listing with 'id'=100\"/)
      end
    end
  end

  # Test duite for POST /listings
  describe 'POST /listings' do
    #valid payload
    let(:valid_attributes) {{
                             address: 'Nre', zip_code: '44', city: 'NY', state: 'New York',
                             bed: '4', bath: '5', sqft: '6', property_type: 'apartment', built_year: '1985',
                             sale_type: 'Buy', price: '2000', title: 'Best Apartment to let in New York',
                             description: 'A better well living apartment in new york',
                             virtual_tour: 'http://youtube.com/3hjhd', display_img: 'http://gph.is/1mbBUKP',
                             status: 'Available', created_by: advertiser.id.to_s
                            }}.to_json
    context 'when the request is valid' do
      before { post '/listings', params: valid_attributes, headers: headers }

      it "creates a listing" do
        expect(json['title']).to eq('Best Apartment to let in New York')
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/listings', params:{ title: 'qet' }, headers: headers  }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end

      it "returns a validation failure message" do
        expect(response.body).to match(/Validation failed: Address can't be blank, Zip code can't be blank, City can't be blank, State can't be blank, Bed can't be blank, Bath can't be blank, Sqft can't be blank, Property type can't be blank, Built year can't be blank, Sale type can't be blank, Price can't be blank, Description can't be blank, Display img can't be blank, Created by can't be blank\"/)
      end
    end
  end

  # test suite for PUT /listings/:id
  describe 'PUT /listings/:id' do
    let(:valid_attributes) { { title: 'Shopping' }.to_json }

    context 'when the record exists' do
      before { put "/listings/#{listing_id}", params:valid_attributes, headers: headers }

      it "updates the record" do
        expect(response.body).to be_empty
      end

      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for Delete /listings/:id

  describe 'DELETE /listings/:id' do
    before { delete "/listings/#{listing_id}", headers: headers }

    it "returns status code 204" do
      expect(response).to have_http_status(204)
    end
  end
end
