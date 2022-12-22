class AdminMailer < ApplicationMailer
  default from: ENV['admin_email']

  # this mailer action sends the email
  def pinned_tweet_purchased_email
    @url = Feedback.last[:tweet_url] # grab last Feedback
    mail(to: ENV['admin_email'], subject: 'A pinned tweet has been purchased') # send email
  end
end
