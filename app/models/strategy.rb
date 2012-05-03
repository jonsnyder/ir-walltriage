class Strategy < ActiveRecord::Base

  belongs_to :mallet_run
  has_many :lda_post_tags
  
  serialize :options, Hash

  def tagged_posts
    lda_post_tags.select('distinct post_id').count
  end

  def tags
    lda_post_tags.count
  end

  def unique_tags
    lda_post_tags.select('distinct lda_topic_id').count
  end

end
