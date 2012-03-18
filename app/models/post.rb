class Post < ActiveRecord::Base
  belongs_to :page
  belongs_to :dataset
  has_many :comments, :dependent => :destroy
  has_many :user_post_tags
  has_many :user_comment_tags, :through => :comments

  scope :no_dataset, where( :dataset_id => nil)

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

  def update_tags( tags, user)
    self.user_post_tags.user( user).destroy_all
    tags.each do |tag|
      self.user_post_tags.user( user).create( :tag => tag)
    end    
  end

  def tags_csv( user)
    user_post_tags.user( user).map(&:tag).sort.join(',')
  end

  def to_mallet
    ret = id.to_s + " en"

    Tokenizer.scan( message) do |word|
      ret += " " + word
    end
    comments.each do |comment|
      Tokenizer.scan( comment.message) do |word|
        ret += " " + word
      end
    end
    
    ret
  end
  
private
  
  def load_comment_from_facebook( comment)
    c = comments.find_by_facebook_id( comment["id"])
    if c.nil?
      c = comments.new
    end
    c.load_from_facebook( comment)
    c.save
  end
end
