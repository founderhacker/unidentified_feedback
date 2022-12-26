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

    # check if there are jobs and check to see if they most recent job has happened already. if not, use that job's run_at time and add X minutes to it to create the run_at time for the next job to be run

    # else just delay by X minutes (X is modifiable via ENV)
    if Delayed::Job.count > 0
      Delayed::Job.where.not(last_error: nil).destroy_all # clear the jobs table of jobs with errors
      if Delayed::Job.last.run_at.past? == false
        next_scheduled_job_run_at_time = Delayed::Job.last.run_at + (ENV['delayed_delay_minutes'].to_i * 60)
        job = TwitterServiceJob.set(wait_until: next_scheduled_job_run_at_time).perform_later(self)
      end
    else 
      job = TwitterServiceJob.set(wait: ENV['delayed_delay_minutes'].to_i.minute).perform_later(self)
    end
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
