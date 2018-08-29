require 'rails_helper'


RSpec.describe 'ListImages API', type: :request do
  # initialize test data
  let!(:listing) { create(:listing) }
  let!(:listimages) { create_list(:listimage, 20, listing_id: listing.id) }
  let(:listing_id) { listing.id }
  let(:id) { listimages.first.id }
  let!(:advertiser) { create(:advertiser) }
  let(:headers) { valid_advertiser_headers }

  # Test suite for GET /listings/:listing_id/listimages
  describe 'GET /listings/:listing_id/listimages' do
    before { get "/listings/#{listing_id}/listimages", params: {}, headers: headers }

    context 'when listing exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all listing images' do
        expect(json.size).to eq(20)
      end
    end

    context 'when listing does not exist' do
      let(:listing_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Listing/)
      end
    end
  end

  # Test suite for POST /listings/
  describe 'POST /listings/:listing_id/listimages' do
    let(:valid_attributes) {{
        photo: 'http://gph.is/1mbBUKP'
      }}

    context 'when request attributes are valid' do
      before { post "/listings/#{listing_id}/listimages", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/listings/#{listing_id}/listimages", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Photo can't be blank/)
      end
    end
  end

  # Test suite for PUT /listings/:listing_id/listimage/:id
  describe 'PUT /listings/:listing_id/listimages/:id' do
    let(:valid_attributes) { { photo: 'assets/nh.png' } }

    before { put "/listings/#{listing_id}/listimages/#{id}", params: valid_attributes, headers: headers }

    context 'when listing exists' do
      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end

      it "updates the photo" do
        updated_listimage = Listimage.find(id)
        expect(updated_listimage.photo).to match('assets/nh.png')
      end
    end

    context 'when the item does not exist' do
      let(:id) { 0 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Listimage/)
      end
    end
  end

  # Test suite for Delete /listings/:id
  describe 'DELETE /listings/:id' do
    before { delete "/listings/#{listing_id}/listimages/#{id}", headers: headers }

    it "returns status code 204" do
      expect(response).to have_http_status(204)
    end
  end
end
