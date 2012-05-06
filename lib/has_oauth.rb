module HasOauth
  
  def oauth
    @oauth = Koala::Facebook::OAuth.new( Walltriage::Application.config.facebook_app_id,
                                         Walltriage::Application.config.facebook_secret,
                                         fb_access_tokens_url)

  end
end
