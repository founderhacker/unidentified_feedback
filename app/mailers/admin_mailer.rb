class AdminMailer < ApplicationMailer
  default from: ENV['admin_email']

  # this mailer action sends the email
  def pinned_tweet_purchased_email
    @feedback_id = params[:feedback_id]
    @url = Feedback.find(@feedback_id)[:tweet_url] # grab last Feedback
    mail(to: ENV['admin_email'], subject: 'A pinned tweet has been purchased') # send email
  end
end
