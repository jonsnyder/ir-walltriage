class Strategy::FirstNTopics < Strategy

  belongs_to :mallet_run
  
  after_initialize :init
  def init
    options[:n] ||= 2
    self.name = "First #{options[:n]} Topics"
  end

  def run
    mallet_run.dataset.posts do |post|
      difference = false
      post.lda_post_topics.sort("weight").limit( options[:n] + 1).reverse.each_cons(2) do |lda_post_topic_n, lda_post_topic_n_minus_one|
        difference ||= lda_post_topic_n.weight > lda_post_topic_n_minus_one.weight
        if difference
          lda_post_tags.create( :lda_topic => lda_post_topic.lda_topic_id, :post_id => lda_post_topic.post_id)
        end
      end
    end
  end
  
end
