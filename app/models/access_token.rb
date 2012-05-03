class AccessToken < ActiveRecord::Base

  has_many :user_post_tags
  
  def get_user_info_from_facebook
    me = graph.get_object("me")
    self.fbid = me["id"]
    self.name = me["name"]
  end
  
  def graph
    Koala::Facebook::API.new( access_token)
  end

  def is_superuser
    return fbid == "73001969"
  end
  
  def self.graph
    AccessToken.offset(rand(AccessToken.count)).first.graph
  end

  def tagged_posts( dataset) 
    user_post_tags.select('distinct post_id').includes( :post).where( :posts => { :dataset_id => dataset.id}).count
  end

  def tags( dataset)
    user_post_tags.includes( :post).where( :posts => { :dataset_id => dataset.id}).count
  end

  def unique_tags( dataset)
    user_post_tags.select('distinct tag').includes( :post).where( :posts => { :dataset_id => dataset.id}).count
  end
end
