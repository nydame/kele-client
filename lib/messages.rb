module Messages
  attr_accessor :page_num

  def get_messages(page_num = nil)
    options = page_num ? {headers: auth_header, body: {page: page_num}} : {headers: auth_header}
    begin
      messages_response = self.class.get('/message_threads', options)
    rescue HTTParty::Error
      puts "Requested data could not be sent: #{messages_response.message}."
    rescue => e
      puts "Something went wrong: #{e.message}."
    end
  end

  def create_message(recipient_id, subject, text, token=nil)
    options = {
      headers: auth_header,
      body: {
        sender: @response['user']['email'],
        recipient_id: recipient_id,
        subject: Sanitize.fragment(subject, Sanitize::Config::RESTRICTED),
        stripped_text: Sanitize.fragment(text, Sanitize::Config::RESTRICTED),
      },
    }
    if token != nil
      options[:body][:token] = token
    end
    begin
      new_message_response = self.class.post('/messages', options)
    rescue HTTParty::Error
      puts "Requested data could not be sent: #{new_message_response.message}."
    rescue => e
      puts "Something went wrong: #{e.message}."
    end
  end
end
