class AdminMailer < ApplicationMailer
  default to: ENV['admin_email']

  def pinned_tweet_purchased_email(feedback)
    @url = feedback.tweet_url
    mail(subject: 'A pinned tweet has been purchased')
  end
end
