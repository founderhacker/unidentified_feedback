class PagesController < ApplicationController
  def home
  end

  def thanks
    # when user gets to this page, send email to me
    AdminMailer.pinned_tweet_purchased_email.deliver_later
  end
  
end
