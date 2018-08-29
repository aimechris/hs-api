class AdvertisersController < ApplicationController
  # POST /signup
  # return authenticated token upon signup
  def create
    advertiser = Advertiser.create!(advertiser_params)
    auth_token = AuthenticateAdvertiser.new(advertiser.email, advertiser.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  private

  def advertiser_params
    params.permit(
      :first_name,
      :last_name,
      :phone,
      :address
      :email,
      :password,
      :password_confirmation
    )
  end
end
