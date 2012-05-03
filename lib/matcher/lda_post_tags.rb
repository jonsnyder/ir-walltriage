class Matcher::LdaPostTags
  extend ActiveSupport::Memoizable

  def initialize( strategy)
    @strategy = strategy
  end

  def matches?( a, b)
    (topic_ids_for_post(a) & topic_ids_for_post(b)).size > 0
  end

  protected

  def topic_ids_for_post( id)
    @strategy.lda_post_tags.select(:lda_topic_id).where( :post_id => id).map(&:lda_topic_id)
  end
  memoize :topic_ids_for_post

end
