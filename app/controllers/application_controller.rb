class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  # called before every action on controllers
  before_action :advertiser_authorize_request
  before_action :author_authorize_request

  attr_reader :current_advertiser
  attr_reader :current_author

  private

  # Check for valid request token and return advertiser
  def advertiser_authorize_request
    @current_advertiser = (AdvertiserAuthorizeApiRequest.new(request.headers).call)[:advertiser]
  end

  def author_authorize_request
    @current_author = (AuthorAuthorizeApiRequest.new(request.headers).call)[:author]
  end
end
