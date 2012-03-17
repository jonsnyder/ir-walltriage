class HomeController < ApplicationController
  include HasOauth
  
  def index
    @oauth = oauth
    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
