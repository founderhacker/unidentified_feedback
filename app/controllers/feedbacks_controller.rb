class FeedbacksController < ApplicationController
  def create
    feedback = Feedback.create(feedback_params)
    session[:tweet_url] = feedback.tweet_url

    redirect_to root_path
  end

  def exists
    # function that checks if the handle exists in the database
    # then returns a json object with true

    handle = params[:handle]
    exists = Feedback.exists?(recipient_handle: handle)
    if exists
      feedback = Feedback.where(recipient_handle: handle).last
      render json: {exists: true, existing_feedback_tweet_url: feedback.tweet_url}
    else
      render json: {exists: false}
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:text, :recipient_handle) # => {recipient_handle: 'somewhere', text: 'something'}
  end
end
