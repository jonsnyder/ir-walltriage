class Matcher::LdaPostTags
  extend ActiveSupport::Memoizable

  def initialize( mallet_run_id, strategy_id)
    @mallet_run_id = mallet_run_id
    @strategy_id = strategy_id
  end

  def matches?( a, b)
    (topic_ids_for_post(a) & topic_ids_for_post(b)).size > 0
  end

  protected

  def topic_ids_for_post( id)
    LdaPostTags.select(:lda_topic_id).includes(:lda_topics).where( :lda_topics => { :mallet_run_id => @mallet_run_id }, :post_id => id).map(&:lda_topic_id)
  end
  memoize :topic_ids_for_post

end
