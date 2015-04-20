class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    # auth.each do |auth_item|
    #   p auth_item
    #   p
    # end

    # Find or Create the User
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)

    # Storing important info in the session
    session[:user_id] = user.id
    session[:access_token] = request.env['omniauth.auth']['credentials']['token']
    session[:access_token_secret] = request.env['omniauth.auth']['credentials']['secret']
    session[:description] = ""

    # Redirecting back to the root
    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

end