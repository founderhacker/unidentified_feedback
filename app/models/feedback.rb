class Feedback < ApplicationRecord
  # validations
  before_create :sanitize
  after_create :send_tweet

  validates_presence_of :recipient_handle, :text
  validates_length_of :text, minimum: 1, maximum: 250

  def sanitize
    # insert ANY logic we want regarding the transformation of text, recipient_handle, etc fields
    self.recipient_handle = self.recipient_handle.gsub('@', '')
  end

  def send_tweet
    TwitterService.tweet!(self)
  end
end
