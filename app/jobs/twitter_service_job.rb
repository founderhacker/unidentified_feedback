class TwitterServiceJob < ApplicationJob
  queue_as :default 

  def perform(feedback)
    TwitterService.tweet!(feedback)
  end
end