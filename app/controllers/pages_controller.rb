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

  private

  def set_feedback
    @feedback = Feedback.find(params[:feedback_id])
  end
end
