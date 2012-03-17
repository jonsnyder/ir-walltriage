class Post < ActiveRecord::Base
  belongs_to :page
  has_many :comments

  self.inheritance_column = 'class'
  
  def load_from_facebook( post)
    puts post
    self.facebook_id = post["id"]
    self.from_name = post["from"]["name"]
    self.from_id = post["from"]["id"]
    self.message = post["message"]
    self.type = post["type"]
    self.created_time = post["created_time"]
    self.photo_url = post["picture"]
    self.link_url = post["link"]
    self.link_name = post["name"]
    self.link_caption = post["caption"]
    self.link_desc = post["description"]
    self.video_url = post["source"]
    self.like_count = post["likes"] ? post["likes"]["count"] : 0
    self.comment_count = post["comments"] ? post["comments"]["count"] : 0
    self.share_count = post["shares"] ? post["shares"]["count"] : 0
    if post["comments"] && post["comments"]["data"]
      post["comments"]["data"].each do |comment|
        load_comment_from_facebook( comment)
      end
    end
  end


private
  
  def load_comment_from_facebook( comment)
    c = Comment.find_by_facebook_id( comment["id"])
    if c.nil?
      c = comments.new
    end
    c.load_from_facebook( comment)
    c.save
  end
end