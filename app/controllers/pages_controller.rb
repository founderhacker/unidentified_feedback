class PagesController < ApplicationController
  def home
    @pay_link_url = StripeService.create_pay_link(session[:feedback_id])

    if Feedback.count > 0
      tweet_job_run_at = Feedback.find(session[:feedback_id]).delayed_job_scheduled_at.to_i
      @estimated_minutes_until_tweet = (tweet_job_run_at - Time.new.to_i).fdiv(60).ceil
    end
    
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
