class ListingsController < ApplicationController
  skip_before_action :author_authorize_request
  skip_before_action :advertiser_authorize_request, only:[:index, :search, :filter, :show]
  before_action :set_listing, only:[:show, :update, :destroy]

  # Root Content
  def index
    @listings = Listing.all
    json_response(@listings)
  end
  #search
  def search
    @listings = Listing.salestype(params[:sale_type]).location(params[:location])
    json_response(@listings)
  end
  #filter
  def filter
    @listings = Listing.salestype(params[:sale_type]).location(params[:location]).min_price(params[:min_price]).max_price(params[:max_price])
    json_response(@listings)
  end
  # show
  def show
    json_response(@listing)
  end
  # Create Listing
  def create
    @listing = Listing.create!(listing_params)
    json_response(@listing, :created)
  end
  # Update Listing
  def update
    @listing.update(listing_params)
    head :no_content
  end
  # Destroy Listing
  def destroy
    @listing.destroy
    head :no_content
  end

  private

  def listing_params
    params.permit(:address, :zip_code, :city, :state,
                  :bed, :bath, :sqft, :property_type,
                  :built_year, :sale_type, :price,
                  :title, :description, :virtual_tour,
                  :display_img, :status, :created_by,
                  :listimages_attributes
                )
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end
end
