require "rails_helper"

RSpec.describe ApplicationController, type: :controller do
  # create test user
  let!(:advertiser) { create(:advertiser) }
  let!(:author) { create(:author) }
   # set headers for authorization
  let(:advertiser_headers) { { 'Authorization' => advertiser_token_generator(advertiser.id) } }
  let(:invalid_advertiser_headers) { { 'Authorization' => nil } }
  let(:author_headers) { { 'Authorization' => author_token_generator(author.id) } }
  let(:invalid_author_headers) { { 'Authorization' => nil } }

  describe "#advertiser_authorize_request" do
    context "when auth token is passed" do
      before { allow(request).to receive(:advertiser_headers).and_return(advertiser_headers) }

      # private method authorize_request returns current user
      it "sets the current advertiser" do
        expect(subject.instance_eval { advertiser_authorize_request }).to eq(advertiser)
      end
    end

    context "when auth token is not passed" do
      before do
        allow(request).to receive(:advertiser_headers).and_return(invalid_advertiser_headers)
      end

      it "raises MissingToken error" do
        expect { subject.instance_eval { authorize_request } }.
          to raise_error(ExceptionHandler::MissingToken, /Missing token/)
      end
    end
  end

  describe "#author_authorize_request" do
    context "when auth token is passed" do
      before { allow(request).to receive(:author_headers).and_return(author_headers) }

      # private method authorize_request returns current user
      it "sets the current author" do
        expect(subject.instance_eval { author_authorize_request }).to eq(author)
      end
    end

    context "when auth token is not passed" do
      before do
        allow(request).to receive(:author_headers).and_return(invalid_author_headers)
      end

      it "raises MissingToken error" do
        expect { subject.instance_eval { author_authorize_request } }.
          to raise_error(ExceptionHandler::MissingToken, /Missing token/)
      end
    end
  end
end
