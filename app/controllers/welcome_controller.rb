class WelcomeController < ApplicationController
  before_action

  def index
    @description = session[:description]
    if current_user
      create_client
      @friends = @@client.friends
    end
  end

  def description
    session[:description] = params[:description]

    redirect_to root_path
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


