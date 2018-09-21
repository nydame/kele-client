module Roadmap
  attr_accessor :chain_id, :checkpoint_id

  def get_roadmap(chain_id)
    begin
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
    begin
      checkpoint_response = self.class.get("/checkpoints/#{checkpoint_id}", headers: auth_header)
      checkpoint_json = checkpoint_response.body
      checkpoint_hash = Oj.load(checkpoint_json)
    rescue HTTParty::Error
      puts "Requested data could not be sent: #{checkpoint_response.message}."
    rescue => e
      puts "Something went wrong: #{e.message}."
    end
  end

  def get_remaining_checkpoints(chain_id)
    begin
      remaining_checkpoint_response = self.class.get("/enrollment_chains/#{chain_id}/checkpoints_remaining_in_section", headers: auth_header)
      remaining_checkpoint_json = remaining_checkpoint_response.body
      remaining_checkpoint_hash = Oj.load(remaining_checkpoint_json)
    rescue HTTParty::Error
      puts "Requested data could not be sent: #{remaining_checkpoint_response.message}."
    rescue => e
      puts "Something went wrong: #{e.message}."
    end
  end

end
