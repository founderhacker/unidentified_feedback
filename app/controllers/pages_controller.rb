class PagesController < ApplicationController
  before_action :set_feedback, only: [:payment_received]

  def home
  end

  def thanks
  end

  def payment_received
    AdminMailer.pinned_tweet_purchased_email(@feedback).deliver_later
    session[:tweet_url] = @feedback.tweet_url

    redirect_to thanks_path
  end

  def feedback_in_queue
    # present user with estimated time until feedback is tweeted
    if Feedback.count > 0
      tweet_job_scheduled_at_time = Feedback.find(session[:feedback_id]).delayed_job_scheduled_at.to_i
      @estimated_minutes_until_tweet = (tweet_job_scheduled_at_time - Time.new.to_i).fdiv(60).ceil
    end
  end
  
  
  private

  def set_feedback
    @feedback = Feedback.find(params[:feedback_id])
  end
end
