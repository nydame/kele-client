require 'httparty'
require 'pp'

class Kele
  include HTTParty

  base_uri 'https://www.bloc.io/api/v1'
  format :json

  def initialize(email, password)
    @email = email
    @password = password
    @auth_token = self.class.post('/sessions', {
      body: {
        email: @email,
        password: @password
      }
      })
  end

end
