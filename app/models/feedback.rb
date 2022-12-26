class Feedback < ApplicationRecord
  # validations
  before_create :sanitize
  after_create :send_tweet

  validates_presence_of :recipient_handle, :text
  validates_length_of :text, minimum: 1, maximum: 250

  def self.for_handle(recipient_handle)
    where(recipient_handle: recipient_handle)
  end

  def sanitize
    # insert ANY logic we want regarding the transformation of text, recipient_handle, etc fields
    self.recipient_handle = self.recipient_handle.gsub('@', '')
  end

  def send_tweet
    #TwitterService.tweet!(self)
    job = TwitterServiceJob.set(wait: ENV['delayed_delay_time'].to_i.minute).perform_later(self)
    self.update(delayed_job_id: JSON.parse(job.to_json)["provider_job_id"]) # update feedback with the id its job
    self.update(delayed_job_scheduled_at: JSON.parse(job.to_json)["scheduled_at"]) # update feedback with the id its job
  end

  # feature - combines all feedback for a given recipient_handle in 1 Twitter thread
  def threadable?
    self.class.for_handle(recipient_handle).count > 1
  end

  def previous_tweet_id
    self.class.for_handle(recipient_handle).where("created_at < ?", created_at).order(created_at: :desc).first.tweet_id
  end
end
