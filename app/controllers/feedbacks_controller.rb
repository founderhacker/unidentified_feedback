class FeedbacksController < ApplicationController
  def create
    feedback = Feedback.create(feedback_params)
    # dummy comment to check git push
    session[:tweet_url] = feedback.tweet_url

    redirect_to root_path
  end

  private

  def feedback_params
    params.require(:feedback).permit(:text, :recipient_handle) # => {recipient_handle: 'somewhere', text: 'something'}
  end
end
