class Post < ActiveRecord::Base
  belongs_to :page
  belongs_to :dataset
  has_many :comments, :dependent => :destroy
  has_many :user_post_tags
  has_many :user_comment_tags, :through => :comments
  has_many :lda_post_topics
  has_many :lda_post_tags
  
  scope :not_authored_by, lambda { |id| where('posts.from_id != ?', id) }
  scope :no_dataset, where( :dataset_id => nil)
  scope :tags_any, lambda { |tags,user| includes(:user_post_tags).where("user_post_tags.access_token_id = ?", user.id).where( tags.map { |tag| "user_post_tags.tag = '#{tag}'" }.join(" OR ") ) }
  scope :tags_all, lambda { |tags,user| tags_any( tags,user).group( 'posts.id').having( 'count(*) = ?', tags.count) }
  scope :untagged, lambda { |user|
    joins("LEFT OUTER JOIN user_post_tags upt ON posts.id = upt.post_id AND upt.access_token_id = #{user.id}").where("upt.id IS NULL")
  }
  scope :search, lambda { |search| where( Enumerator.new { |y| Tokenizer.scan(search) { |term| y << term}}.map { |term| "posts.search LIKE '% " + term + " %'" }.join(" AND ")) } 

  self.inheritance_column = 'class'

  def update_from_facebook
    post = graph.get_object( facebook_id)
    if post
      load_from_facebook( post)
    end
  end
  
  def load_from_facebook( post)
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
    self.share_count = post["shares"] ? post["shares"]["count"] : 0
    if post["comments"]
      self.comment_count = post["comments"]["count"]
      if post["comments"]["data"]
        post["comments"]["data"].each do |comment|
          load_comment_from_facebook( comment)
        end
        if comment_count > post["comments"]["data"].length
          fetch_comments
        end
      end
    else
      self.comment_count = 0
    end
  end

  def update_tags( tags, user)
    self.user_post_tags.user( user).destroy_all
    tags.each do |tag|
      if !tag.strip.blank?
        self.user_post_tags.user( user).create( :tag => tag.strip)
      end
    end    
  end

  def update_search
    self.search = tokenized { |word| true }.join(" ")
    self.save!
  end
  
  def tags_csv( user)
    user_post_tags.user( user).map(&:tag).sort.join(',')
  end

  def to_mallet
    id.to_s + " en " + tokenized { |word| yield word }.join(' ')
  end

  def tokenized
    ret = []
    Tokenizer.scan( message) do |word|
      if yield word
        ret << word
      end
    end
    comments.each do |comment|
      Tokenizer.scan( comment.message) do |word|
        if yield word
          ret << word
        end
      end
    end
    
    ret
  end

  def fetch_comments
    comments = graph.get_connections( facebook_id, 'comments')
    
    while comments && comments.length > 0
      comments.each do |comment|
        load_comment_from_facebook( comment)
      end

      comments = comments.next_page
    end
  end

  def graph
    AccessToken.graph
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
