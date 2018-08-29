class ListimagesController < ApplicationController
  skip_before_action :author_authorize_request
  skip_before_action :advertiser_authorize_request, only:[:index, :search, :filter, :show]
  before_action :set_listing
  before_action :set_listing_listimage, only: [:show, :update, :destroy]

  # GET /listings/:listing_id/listimages

  def index
    json_response(@listing.listimages)
  end

  def show
    json_response(@listimage)
  end

  def create
    @listing.listimages.create!(listimage_params)
    json_response(@listing, :created)
  end

  def update
    @listimage.update(listimage_params)
    head :no_content
  end

  def destroy
    @listimage.destroy
    head :no_content
  end

  private

  def listimage_params
    params.permit(:photo)
  end

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

  def set_listing_listimage
    @listimage = @listing.listimages.find_by!(id: params[:id]) if @listing
  end
end
