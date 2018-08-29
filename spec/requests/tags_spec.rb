require 'rails_helper'


RSpec.describe 'Tags API', type: :request do
  # initialize test data
  let(:category) { create(:category) }
  let!(:author) { create(:author) }
  let(:category_id) { category.id }
  let!(:post) { create(:post, category_id: category.id) }
  let!(:tags) { create_list(:tag, 5, post_id: post.id) }
  let(:id) { tags.first.id }
  let(:headers) { valid_author_headers }

  # Test suite for GET /listings/:listing_id/listimages
  describe 'GET /posts/:post_id/tags' do
    before { get "/posts/#{post_id}/tags", params: {}, headers: headers }

    context 'when post exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all post tags' do
        expect(json.size).to eq(20)
      end
    end

    context 'when post does not exist' do
      let(:post_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Post/)
      end
    end
  end

  # Test suite for POST /listings/
  describe 'POST /posts/:post_id/tags' do
    let(:valid_attributes) {{
        tag_name: 'decor'
      }}

    context 'when request attributes are valid' do
      before { post "/posts/#{post_id}/tags", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/posts/#{post_id}/tags", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Tag name can't be blank/)
      end
    end
  end

  # Test suite for PUT /listings/:listing_id/listimage/:id
  describe 'PUT /posts/:post_id/tags/:id' do
    let(:valid_attributes) { { tag_name: 'decoration' } }

    before { put "/posts/#{post_id}/tags/#{id}", params: valid_attributes, headers: headers }

    context 'when listing exists' do
      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end

      it "updates the tag_name" do
        updated_tagname = Tag.find(id)
        expect(updated_tagname.tag_name).to match('decoration')
      end
    end

    context 'when the item does not exist' do
      let(:id) { 0 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Tag name/)
      end
    end
  end

  # Test suite for Delete /listings/:id
  describe 'DELETE /posts/:id' do
    before { delete "/posts/#{post_id}/tags/#{id}", headers: headers }

    it "returns status code 204" do
      expect(response).to have_http_status(204)
    end
  end
end
