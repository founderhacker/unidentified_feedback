class Feedback < ApplicationRecord

  # pseudo-code logic
  # 1. user creates feedback record
  # 2. tweet the "text" attribute of the feedback record, to the "recipient_handle" attribute

  after_create :send_tweet

  def send_tweet
    puts "Sending tweet!"
    # insert twitter API logic here
  end
end
