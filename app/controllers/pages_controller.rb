class PagesController < ApplicationController
  def home
    # create pay to pin pay link
    @pay_link_url = StripeService.create_pinned_tweet_pay_link(session[:feedback_id])
  end

  def pinned_tweet_thanks
    session[:tweet_url] = Feedback.find(session[:feedback_id]).tweet_url
  end

  def skip_queue_thanks
    session[:tweet_url] = Feedback.find(session[:feedback_id]).tweet_url
    # create pay to pin pay link
    @pay_link_url = StripeService.create_pinned_tweet_pay_link(session[:feedback_id])
  end

  def pinned_tweet_payment_received
    @feedback_id = params[:feedback_id]
    # when user gets to this page, send email to me
    AdminMailer.with(feedback_id: @feedback_id).pinned_tweet_purchased_email.deliver_later
    redirect_to pinned_tweet_thanks_path
  end

  def skip_queue_payment_received
    @feedback_id = params[:feedback_id]
    # when user gets to this page, send email to me about the payment + change the job's run_at time to now
    AdminMailer.with(feedback_id: @feedback_id).skip_queue_purchased_email.deliver_later
    job = Delayed::Job.find(Feedback.find(@feedback_id).delayed_job_id)
    job.update(:run_at => Time.now, :attempts => 0)
    job.save
    redirect_to skip_queue_thanks_path
  end

  def feedback_in_queue
    # create skip queue pay link
    @pay_link_url = StripeService.create_skip_queue_pay_link(session[:feedback_id])

    # present user with estimated time until feedback is tweeted
    if Feedback.count > 0
      tweet_job_scheduled_at_time = Feedback.find(session[:feedback_id]).delayed_job_scheduled_at.to_i
      @estimated_minutes_until_tweet = (tweet_job_scheduled_at_time - Time.new.to_i).fdiv(60).ceil
    end
  end
  
  
end
