class Dataset < ActiveRecord::Base
  has_many :posts, :dependent => :destroy
  
  def copy_posts_into_dataset( posts)
    posts.each do |post|
      new_post = post.dup
      new_post.dataset = self
      new_post.save
      post.comments.each do |comment|
        new_comment = comment.dup
        new_comment.post = new_post
        new_comment.save
      end
    end
  end
end
