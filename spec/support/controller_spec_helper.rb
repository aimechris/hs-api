module ControllerSpecHelper
  # generate tokens from advertiser id
  def advertiser_token_generator(advertiser_id)
    JsonWebToken.encode(advertiser_id: advertiser_id)
  end
  # generate tokens from author id
  def author_token_generator(author_id)
    JsonWebToken.encode(author_id: author_id)
  end
  # generate tokens from user id
  def user_token_generator(user_id)
    JsonWebToken.encode(user_id: user_id)
  end

  # generate expired tokens from advertiser id
  def expired_advertiser_token_generator(advertiser_id)
    JsonWebToken.encode({ advertiser_id: advertiser_id }, (Time.now.to_i - 10))
  end
  # generate expired tokens from author id
  def expired_author_token_generator(author_id)
    JsonWebToken.encode({ author_id: author_id }, (Time.now.to_i - 10))
  end
  # generate expired tokens from author id
  def expired_user_token_generator(user_id)
    JsonWebToken.encode({ user_id: user_id }, (Time.now.to_i - 10))
  end

  # return valid advertiser headers
  def valid_advertiser_headers
    {
      "Authorization" => advertiser_token_generator(advertiser.id)
    }
  end

  # return invalid advertiser headers
  def invalid_advertiser_headers
    {
      "Authorization" => nil
    }
  end

  # return valid author headers
  def valid_author_headers
    {
      "Authorization" => author_token_generator(author.id)
    }
  end

  # return invalid author headers
  def invalid_author_headers
    {
      "Authorization" => nil,
    }
  end
  # return valid user headers
  def valid_user_headers
    {
      "Authorization" => user_token_generator(user.id)
    }
  end

  # return invalid user headers
  def invalid_user_headers
    {
      "Authorization" => nil
    }
  end
end
