class FeaturesController < ApplicationController
  skip_before_action :author_authorize_request
  skip_before_action :advertiser_authorize_request, only:[:index, :show]
  before_action :set_feature, only:[:show, :update, :destroy]
  # Root Content
  def index
    @features = Feature.all
    json_response(@features)
  end
  # show
  def show
    json_response(@feature)
  end
  # Create Listing
  def create
    @feature = Feature.create!(feature_params)
    json_response(@feature, :created)
  end
  # Update Listing
  def update
    @feature.update(feature_params)
    head :no_content
  end
  # Destroy Listing
  def destroy
    @feature.destroy
    head :no_content
  end

  private

  def feature_params
    params.permit(:feature_name)
  end

  def set_feature
    @feature = Feature.find(params[:id])
  end
end
