def TweetJob < ApplicationJob
  queue_as :default 

  def perform(any: 'arguments')
    # do something here
  end
end