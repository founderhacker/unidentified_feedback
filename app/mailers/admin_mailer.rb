class AdminMailer < ApplicationMailer
  default from: ENV['admin_email']

  def pinned_tweet_purchased_email
    mail(to: ENV['admin_email'], subject: 'A pinned tweet has been purchased')
  end
end
