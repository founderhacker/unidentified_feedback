class PagesController < ApplicationController
  def home
    @pay_link_url = StripeService.create_pay_link(session[:feedback_id])
  end

  def thanks
  end

  def payment_received
    @feedback_id = params[:feedback_id]
    # when user gets to this page, send email to me
    AdminMailer.with(feedback_id: @feedback_id).pinned_tweet_purchased_email.deliver_later
    redirect_to thanks_path
  end
  
end
