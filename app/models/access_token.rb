class AccessToken < ActiveRecord::Base

  def get_user_info_from_facebook
    me = graph.get_object("me")
    self.fbid = me["id"]
    self.name = me["name"]
  end
  
private

  def graph
    Koala::Facebook::API.new( access_token)
  end
end
