class Matcher::UserPostTags
  extend ActiveSupport::Memoizable

  def initialize( access_token_id)
    @access_token_id = access_token_id
  end

  def matches?( a, b)
    (tags_for_post(a) & tags_for_post(b)).size > 0
  end
  
  protected

  def tags_for_post( id)
    UserPostTag.select(:tag).where(:post_id => id, :access_token_id => @access_token_id).map(&:tag)
  end
  memoize :tags_for_post
end
