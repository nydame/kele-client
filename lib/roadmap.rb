module Roadmap
  attr_accessor :chain_id, :checkpoint_id

  def get_roadmap(chain_id)
    begin
      auth_header = { authorization: @response['auth_token'] }
      roadmap_response = self.class.get("/roadmaps/#{chain_id}", headers: auth_header)
      roadmap_json = roadmap_response.body
      roadmap_hash = Oj.load(roadmap_json)
    rescue HTTParty::Error
      puts "Requested data could not be sent: #{roadmap_response.message}."
    rescue => e
      puts "Something went wrong: #{e.message}."
    end
  end

  def get_checkpoint(checkpoint_id)
    auth_header = {authorization: @response['auth_token']}
    checkpoint_response = self.class.get("/checkpoints/#{checkpoint_id}", headers: auth_header)
    checkpoint_json = checkpoint_response.body
    checkpoint_hash = Oj.load(checkpoint_json)
  end

end
