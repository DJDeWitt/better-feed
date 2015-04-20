class FriendsController < ApplicationController


  def unfollow
    p params

    create_client

    @@client.unfollow(params["screen_name"])
    render json: 'Successfully unfollowed.'
  end

  def follow
    p params

    create_client

    @@client.follow(params['screen_name'])
    render json: 'Successfully followed.'
  end

  def congratulate
    create_client
    user_name = params['screen_name']

    @@client.update("You've passed my judgement, @"+user_name+": http://betterfeed.com/tweetjudge")
    render json: 'Successfully congratulated.'
  end

  def warn
    create_client
    user_name = params['screen_name']

    @@client.update("You've failed to pass my judgement, @"+user_name+": http://betterfeed.com/tweetjudge")
    render json: 'Successfully warned.'
  end

  def show
    @friend = params[:id]
    @description = session[:description]

    create_client

    # Get friend object
    @friend_object = @@client.user(@friend)

    # @friend_tweets = @@client.user(:id).home_timeline
    @friend_tweets = []

    # store 100 tweets in a temp array
    @temp_tweets = @@client.user_timeline(@friend, :count => 200)#.take(10000)
    p @temp_tweets
    # roll through each one of the temp tweets...
    @temp_tweets.each do |temp_tweet|
      p temp_tweet
      # determining if it starts with @
      if temp_tweet.text[0] != "@"
        # if it doesn't add it to @friend_tweets
        @friend_tweets << temp_tweet
      end
    end

    @friend_tweets = @friend_tweets.take(30)
    # if it gets through the entire array and @friend_tweets doesn't hit the limit, we add more tweets to the temp_array, and keep going through until this is done
  end


  private

  def create_client
    @@client = Twitter::REST::Client.new do |config|
      config.consumer_key        = 'LBGnh2YckjElEXK5d5SKgQwjd'
      config.consumer_secret     = '5bJuP61h4Ceg5cZHoNGMrDDn2TjMlCMlf60gfg58ktWyyWhsC0'
      config.access_token        = session['access_token']
      config.access_token_secret = session['access_token_secret']
    end
  end

end