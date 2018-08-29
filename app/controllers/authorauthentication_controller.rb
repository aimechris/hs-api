class AuthorauthenticationController < ApplicationController
  skip_before_action :author_authorize_request
  skip_before_action :advertiser_authorize_request
  # return auth token once user is authenticated
  def authenticate
    auth_token =
      AuthenticateAuthor.new(auth_params[:email], auth_params[:password]).call
    json_response(auth_token: auth_token)
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
