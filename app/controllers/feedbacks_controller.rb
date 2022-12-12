class FeedbacksController < ApplicationController
  def create
    feedback = Feedback.create(feedback_params)
    session[:tweet_url] = feedback.tweet_url

    redirect_to root_path
  end

  def exists
    # get existing feedback
    feedback = Feedback.find_by(recipient_handle: params[:handle])

    # return json with existing feedback tweet url
    render json: { existing_feedback_tweet_url: feedback&.tweet_url }
  end

  private

  def feedback_params
    params.require(:feedback).permit(:text, :recipient_handle) # => {recipient_handle: 'somewhere', text: 'something'}
  end
end
