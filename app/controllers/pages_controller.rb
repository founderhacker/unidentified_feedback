class PagesController < ApplicationController
  def home
    @pay_link_url = StripeService.create_pay_link(session[:feedback_id])
  end

  def thanks
    @feedback_id = params[:feedback_id]
    # when user gets to this page, send email to me
    AdminMailer.with(feedback_id: @feedback_id).pinned_tweet_purchased_email.deliver_later
  end
  
end
