class AdminMailer < ApplicationMailer
  default from: ENV['admin_email']

  # this mailer action sends the email
  def pinned_tweet_purchased_email
    @feedback_id = params[:feedback_id]
    @url = Feedback.find(@feedback_id)[:tweet_url] 
    mail(to: ENV['admin_email'], subject: 'A pinned tweet has been purchased') # send email
  end

  def skip_queue_purchased_email
    @feedback_id = params[:feedback_id]
    @url = Feedback.find(@feedback_id)[:tweet_url] 
    mail(to: ENV['admin_email'], subject: 'Someone purchased to skip the queue!') # send email
  end
end
