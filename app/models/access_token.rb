class AccessToken < ActiveRecord::Base

  def get_user_info_from_facebook
    me = graph.get_object("me")
    self.fbid = me["id"]
    self.name = me["name"]
  end
  
  def graph
    Koala::Facebook::API.new( access_token)
  end

  def self.graph
    AccessToken.offset(rand(AccessToken.count)).first.graph
  end
end
