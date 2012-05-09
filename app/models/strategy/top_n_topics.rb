class Strategy::TopNTopics < Strategy

  belongs_to :mallet_run
  
  after_initialize :init
  def init
    options[:n] ||= 2
    self.name = "First #{options[:n]} Topics"
  end

  def run
    lda_post_tags.delete_all

    columns = [:lda_topic_id, :post_id, :strategy_id]
    rows = []
    mallet_run.dataset.posts.each do |post|
      difference = false
      post.lda_post_topics.order("weight desc").limit( options[:n] + 1).reverse.each_cons(2) do |lda_post_topic_2, lda_post_topic_1|
        difference ||= (lda_post_topic_2.weight < lda_post_topic_1.weight)
        if difference
          rows << [ lda_post_topic_1.lda_topic_id, post.id, self.id ]
        end

        if rows.size > 1000
          LdaPostTag.import columns, rows, :validate => false
          rows = []
        end
      end
    end
    if rows.size > 0
      LdaPostTag.import columns, rows, :validate => false
    end
    nil
  end
  
end
