class FeedbacksController < ApplicationController
  before_action :set_feedback, only: [:show]

  def create
    feedback = Feedback.create(feedback_params)
    session[:tweet_url] = feedback.tweet_url
    session[:feedback_id] = feedback.id
    redirect_to root_path
  end

  def show
    render json: { existing_feedback_tweet_url: @feedback&.tweet_url }
  end

  private

  def feedback_params
    params.require(:feedback).permit(:text, :recipient_handle) # => {recipient_handle: 'somewhere', text: 'something'}
  end

  def set_feedback
    @feedback = Feedback.find_by(recipient_handle: params[:id])
  end
end
