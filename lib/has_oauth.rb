module HasOauth
  
  def oauth
    @oauth = Koala::Facebook::OAuth.new( Walltriage::Application.config.facebook_app_id,
                                         Walltriage::Application.config.facebook_secret,
                                         access_tokens_fb_url)

  end
end
