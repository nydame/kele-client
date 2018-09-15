require 'httparty'

class Kele
  def initialize(email, token)
    @email = email
    @token = token
    # use httparty to make a call to the Bloc API
  end
end
