module HasOauth
  
  def oauth
    # @oauth = Koala::Facebook::OAuth.new( "316562328389648",
    #                                     "9124392f4ab512679531588a01571b0f",
    #                                     fb_access_tokens_url)
    @oauth = Koala::Facebook::OAuth.new( "319584004769885",
                                         "1add3acf680c2b3c76e8d17362245436",
                                         fb_access_tokens_url)

  end
end
