class InquiriesController < ApplicationController
  skip_before_action :author_authorize_request
  skip_before_action :advertiser_authorize_request
  before_action :set_inquiry, only:[:show, :update, :destroy]
  # Root Content
  def index
    @inquires = Inquiry.all
    json_response(@inquires)
  end
  # show
  def show
    json_response(@inquiry)
  end
  # Create inquiry
  def create
    @inquiry = Inquiry.create!(inquiry_params)
    json_response(@inquiry, :created)
  end
  # Update inquiry
  def update
    @inquiry.update(inquiry_params)
    head :no_content
  end
  # Destroy inquiry
  def destroy
    @inquiry.destroy
    head :no_content
  end

  private

  def inquiry_params
    params.permit(:querry, :created_at, :listing_id)
  end

  def set_inquiry
    @inquiry = Inquiry.find(params[:id])
  end
end
