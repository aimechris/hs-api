class AuthenticateAuthor
  def initialize(email, password)
    @email = email
    @password = password
  end

  # Service entry point
  def call
    JsonWebToken.encode(author_id: author.id) if author
  end

  private

  attr_reader :email, :password

  # verify user credentials
  def author
    author = Author.find_by(email: email)
    return author if author && author.authenticate(password)
    # raise Authentication error if credentials are invalid
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end
