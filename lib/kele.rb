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
      # what to do with token; set cookie???
      # display success message
      puts "You successfully logged into Bloc."
    else
      # raise error
      puts "Login attempt failed: #{@response.message}."
    end
  end

end
