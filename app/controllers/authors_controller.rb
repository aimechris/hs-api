class AuthorsController < ApplicationController
  skip_before_action :author_authorize_request
  skip_before_action :advertiser_authorize_request
  # POST /signup
  # return authenticated token upon signup
  def create
    author = Author.create!(author_params)
    auth_token = AuthenticateAuthor.new(author.email, author.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  private

  def author_params
    params.permit(
      :author_name
      :email,
      :password,
      :password_confirmation
    )
  end
end
