class Feedback < ApplicationRecord
  after_create :send_tweet

  def send_tweet
    TwitterService.tweet!(text)
  end
end
