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

  def create_message(recipient_id, subject, text)
    options = {
      headers: auth_header,
      body: {
        sender: @response['user']['email'],
        recipient_id: recipient_id,
        subject: subject,
        stripped_text: text
      },
    }
    begin
      new_message_response = self.class.post('/messages', options)
    rescue HTTParty::Error
      puts "Requested data could not be sent: #{new_message_response.message}."
    rescue => e
      puts "Something went wrong: #{e.message}."
    end
  end
end
