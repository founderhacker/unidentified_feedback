class PagesController < ApplicationController
  def home
    @pay_link_url = StripeService.create_pay_link(session[:feedback_id])
  end

  def thanks
    @feeback_id = params[:feeback_id]
    # when user gets to this page, send email to me
    AdminMailer.with(feeback_id: @feeback_id).pinned_tweet_purchased_email.deliver_later
  end
  
end
