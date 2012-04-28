class HomeController < ApplicationController
  include HasOauth
  
  def index
    @oauth = oauth
    @user = AccessToken.find_by_id( session[:user_id])
    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
