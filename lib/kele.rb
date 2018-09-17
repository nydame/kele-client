require 'httparty'
require 'pp'

class Kele
  attr_accessor :options, :response

  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'
  format :json

  def initialize(email, password)
    @options = {
      email: email,
      password: password,
    }
    @response = nil

    begin
      @response = self.class.post('/sessions', {
        body: @options
      })
    rescue => e
      puts "Login attempt failed: #{e.message}."
      return
    end

    if @response.message == "OK"
      # what to do with token; set cookie??? I AM STILL NOT LOGGED IN!
      # display success message
      puts "You successfully logged into Bloc."
    else
      # raise error
      puts "Login attempt failed: #{@response.message}."
    end
  end

  def get_me
    begin
      auth_header = { authorization: @response['auth_token'] }
      current_user_response = self.class.get('/users/me', headers: auth_header)
    rescue HTTParty::Error
      puts "Requested data could not be sent: #{current_user_response.message}."
    rescue => e
      puts "Something went wrong: #{e.message}."
    end
  end

end
