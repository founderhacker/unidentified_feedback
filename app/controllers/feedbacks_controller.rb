class FeedbacksController < ApplicationController
  def create
    Feedback.create(feedback_params)
  end

  private

  def feedback_params
    params.require(:feedback).permit(:text, :recipient_handle) # => {recipient_handle: 'somewhere', text: 'something'}
  end
end
