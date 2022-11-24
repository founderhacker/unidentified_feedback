require 'oauth/request_proxy/typhoeus_request'

class TwitterService
  def self.message(feedback)
    ".@#{feedback.recipient_handle}, '#{feedback.text}' --Anon" # => 250 characters
  end

  def self.tweet!(feedback)
    body = { "text": message(feedback) }

    # check if the recipient_handle is in the database
    # and if it is in the database more than once because the last entry in the database is the current tweet we are sending
    # if above condition is true
    # then we need to capture the tweet_id of the previous tweet
    if Feedback.exists?(recipient_handle: feedback.recipient_handle) && Feedback.where(recipient_handle: feedback.recipient_handle).count > 1
      prev_tweet_id = Feedback.where(recipient_handle: feedback.recipient_handle).order(created_at: :desc).offset(1).first.tweet_id
    else
      prev_tweet_id = nil
    end

    # append prev_tweet_id to the body if it is not nil
    if prev_tweet_id
      body[:reply] = {"in_reply_to_tweet_id": prev_tweet_id}
    end

    @consumer = OAuth::Consumer.new(
      ENV['twitter_consumer_key'],
      ENV['twitter_consumer_secret'],
    )
    @token = OAuth::Token.new(ENV['twitter_oauth_token'], ENV['twitter_oauth_token_secret'])
    options = {
      method: :post,
      headers: {
        "content-type" => "application/json"
      },
      body: body.to_json
    }

    oauth_params = {:consumer => @consumer, :token => @token}

    hydra = Typhoeus::Hydra.new
    url = 'https://api.twitter.com/2/tweets'
    req = Typhoeus::Request.new(url, options)
    oauth_helper = OAuth::Client::Helper.new(req, oauth_params.merge(:request_uri => url))
    req.options[:headers].merge!({"Authorization" => oauth_helper.header})

    response = req.run

    if response.success?
      tweet_id = JSON.parse(response.body)['data']['id']
      twitter_username = ENV['twitter_username'] || 'twitter' # will forward regardless
      tweet_url = "https://twitter.com/#{twitter_username}/status/#{tweet_id}"

      feedback.update(tweet_id: tweet_id, tweet_url: tweet_url)

      # TODO: delete logs
      puts "Credentials work! Tweet:"
      puts JSON.pretty_generate(JSON.parse(response.body))
    else
      puts "Credentials failed, please try generating again."
    end
  end
end
