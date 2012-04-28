class HomeController < ApplicationController
  include IsLoggedIn
  before_filter :is_logged_in, :only => [:instructions]
  
  def index
    @oauth = oauth
    @user = AccessToken.find_by_id( session[:user_id])
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def instructions
  end

end
