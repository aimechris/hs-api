require 'rails_helper'

RSpec.describe 'Inquiries API', type: :request do
  # initialize test data
  let!(:listing) { create(:listing) }
  let!(:inquiries) { create_list(:inquiry, 10, listing_id: listing.id) }
  let(:listing_id) { listing.id }
  let(:inquiry_id) { inquiries.first.id }
  let!(:advertiser) { create(:advertiser) }
  let(:headers) { valid_advertiser_headers }
  # Test suite for GET /inquiries
  describe 'GET /inquiries' do
    before { get '/inquiries', headers: headers }

    it "returns inquiries" do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  # Test suit for show action
  describe 'GET /inquiries/:id' do
    before { get "/inquiries/#{inquiry_id}", headers: headers }

    context 'when the record exists' do
      it "returns a inquiry" do
        expect(json).not_to be_empty
        expect(json['id']).to eq(inquiry_id)
      end
      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end
    context 'when the record does not exist' do
      let(:inquiry_id) { 100 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/"Couldn't find Inquiry with 'id'=100\"/)
      end
    end
  end

  # Test duite for POST /inquiries
  describe 'POST /inquiries' do
    #valid payload
    let(:valid_attributes) {{ querry: 'some text'}}
    context 'when the request is valid' do
      before { post '/inquiries', params: valid_attributes, headers: headers }

      it "creates a inquiry" do
        expect(json['querry']).to eq('some text')
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/inquiries', params:{ querry: 'qet' }, headers: headers }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end

      it "returns a validation failure message" do
        expect(response.body).to match(/Validation failed: Listing must exist, Created at can't be blank\"/)
      end
    end
  end

  # test suite for PUT /inquiries/:id
  describe 'PUT /inquiries/:id' do
    let(:valid_attributes) { { querry: 'My Name is Khalid' } }

    context 'when the record exists' do
      before { put "/inquiries/#{inquiry_id}", params:valid_attributes, headers: headers }

      it "updates the record" do
        expect(response.body).to be_empty
      end

      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for Delete /inquiries/:id

  describe 'DELETE /inquiries/:id' do
    before { delete "/inquiries/#{inquiry_id}", headers: headers }

    it "returns status code 204" do
      expect(response).to have_http_status(204)
    end
  end
end
