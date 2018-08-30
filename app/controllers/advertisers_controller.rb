class AdvertisersController < ApplicationController
  skip_before_action :author_authorize_request
  skip_before_action :advertiser_authorize_request
  # POST /signup
  # return authenticated token upon signup
  def create
    advertiser = Advertiser.create!(advertiser_params)
    confirmation = AdvertiserMailer.registration_confirmation(advertiser).deliver
    auth_token = AuthenticateAdvertiser.new(advertiser.email, advertiser.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  def confirm_email
    advertiser = Advertiser.find_by_confirm_token(params[:id])
    if advertiser
      advertiser.email_activate

  end

  def method_name

  end
  private

  def advertiser_params
    params.permit(
      :first_name,
      :last_name,
      :phone,
      :address,
      :email,
      :password,
      :password_confirmation
    )
  end
end
