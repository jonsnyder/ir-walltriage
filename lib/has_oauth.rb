module HasOauth
  
  def oauth
    @oauth = Koala::Facebook::OAuth.new( "316562328389648",
                                         "9124392f4ab512679531588a01571b0f",
                                         fb_access_tokens_url)
  end
end
