class Page < ActiveRecord::Base

  has_many :posts
  
  before_create :get_page_info_from_facebook

  def get_page_info_from_facebook
    page = graph.get_object( username)
    self.facebook_id = page["id"]
    self.name = page["name"]
    self.photo_url = page["picture"]
    self.can_post = page["can_post"]
    self.like_count = page["likes"]
  end

  def graph
    AccessToken.graph
  end

  def fetch_posts( i)
    if i > 0
      wall_posts = graph.get_connections( facebook_id, 'feed')
    end
    while i > 0
      wall_posts.each do |post|
        p = Post.no_dataset.find_by_facebook_id( post["id"])
        if p.nil?
          p = posts.new
        end
        p.load_from_facebook( post)
        p.save
        i -= 1
      end
      if i > 0
        wall_posts = wall_posts.next_page
      end
    end
  end

  def update_comments()

  end
end
