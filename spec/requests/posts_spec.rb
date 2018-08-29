require 'rails_helper'

RSpec.describe 'Posts API', type: :request do
  # initialize test data
  let(:category) { create(:category) }
  let(:category_id) { category.id }
  let!(:posts) { create_list(:post, 10, category_id: category.id) }
  let(:post_id) { posts.first.id }
  let!(:author) { create(:author) }
  let(:headers) { valid_author_headers }
  # Test suite for GET /Listings
  describe 'GET /posts' do
    before { get '/posts', params: {}, headers: headers }

    it "returns posts" do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /search
  describe 'GET /search' do
    before { get '/search', params: {}, headers: headers }

    context 'When searched results found' do
      it "returns posts" do
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
  describe 'GET /posts/:id' do
    before { get "/posts/#{post_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it "returns a post" do
        expect(json).not_to be_empty
        expect(json['id']).to eq(post_id)
      end
      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end
    context 'when the record does not exist' do
      let(:post_id) { 100 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/"Couldn't find Post with 'id'=100\"/)
      end
    end
  end

  # Test duite for POST /posts
  describe 'POST /posts' do
    #valid payload
    let(:valid_attributes) {{
      title: 'How to buy a house',
      subtitle: 'planning to buy a house',
      content: 'agagagfag',
      post_image: 'ahgaghag',
      status: 'publish',
      published_by: 'yu',
      published_at: '2014-09-18 12:30:59'
    }}
    context 'when the request is valid' do
      before { post '/posts', params: valid_attributes, headers: headers }

      it "creates a post" do
        expect(json['title']).to eq('How to buy a house')
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/posts', params:{ title: 'qet' }, headers: headers }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end

      it "returns a validation failure message" do
        expect(response.body).to match(/Validation failed: Category must exist, Content can't be blank, Post image can't be blank\"/)
      end
    end
  end

  # test suite for PUT /posts/:id
  describe 'PUT /posts/:id' do
    let(:valid_attributes) { { title: 'Shopping' } }

    context 'when the record exists' do
      before { put "/posts/#{post_id}", params:valid_attributes, headers: headers }

      it "updates the record" do
        expect(response.body).to be_empty
      end

      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for Delete /listings/:id

  describe 'DELETE /posts/:id' do
    before { delete "/posts/#{post_id}", params: {}, headers: headers }

    it "returns status code 204" do
      expect(response).to have_http_status(204)
    end
  end
end
