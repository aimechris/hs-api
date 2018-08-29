class CategoriesController < ApplicationController
  skip_before_action :advertiser_authorize_request
  before_action :set_category, only:[:show, :update, :destroy]
  # Root Content
  def index
    @categories = Category.all
    json_response(@categories)
  end
  # show
  def show
    json_response(@category)
  end
  # Create Listing
  def create
    @category = Category.create!(category_params)
    json_response(@category, :created)
  end
  # Update Listing
  def update
    @category.update(category_params)
    head :no_content
  end
  # Destroy Listing
  def destroy
    @category.destroy
    head :no_content
  end

  private

  def category_params
    params.permit(:category_name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
