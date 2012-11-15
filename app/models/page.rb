class Page < ActiveRecord::Base

  has_many :posts
  
  before_create :get_page_info_from_facebook

  def posts_not_by_page
    posts.not_authored_by( facebook_id)
  end
  
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
      ActiveRecord::Base.transaction do
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
  end

  def fetch_posts_by_days( days)
    return if days <= 0

    cutoff_day = Date.today - days.days
    
    wall_posts = graph.get_connections( facebook_id, 'feed')
    i = 0
    while true
      ActiveRecord::Base.transaction do
        wall_posts.each do |post|
          p = Post.no_dataset.find_by_facebook_id( post["id"])
          if p.nil?
            p = posts.new
          end
          p.load_from_facebook( post)
          return if p.created_time < cutoff_day
          p.save
          i += 1
          if i % 100 == 0
            puts i
            puts p.created_time.to_s
          end
            
        end
        wall_posts = wall_posts.next_page
        return if wall_posts.nil?
      end
    end
  end

  def update_posts
    posts.no_dataset.each do |post|
      post.update_from_facebook
    end
  end
end
