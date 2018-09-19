require 'httparty'
require 'oj'
require 'pp'
require './lib/roadmap'
require './lib/messages'

class Kele
  attr_accessor :options, :response

  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'
  format :json

  include Oj

  include Roadmap
  include Messages

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
      current_user_response = self.class.get('/users/me', headers: auth_header)
      current_user_json = current_user_response.body
      current_user_hash = Oj.load(current_user_json)
    rescue HTTParty::Error
      puts "Requested data could not be sent: #{current_user_response.message}."
    rescue => e
      puts "Something went wrong: #{e.message}."
    end
  end

  def get_mentor_availability(mentor_id)
    begin
      mentor_availability_response = self.class.get("/mentors/#{mentor_id}/student_availability", headers: auth_header)
      mentor_availability_response.select {|timeslot| timeslot['booked'] == nil}
    rescue HTTParty::Error
      puts "Requested data could not be sent: #{mentor_availability_response.message}."
    rescue => e
      puts "Something went wrong: #{e.message}."
    end
  end

  private

  def auth_header
    {authorization: @response['auth_token']}
  end

end
