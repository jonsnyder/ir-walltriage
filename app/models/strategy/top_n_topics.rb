class Strategy::TopNTopics < Strategy

  belongs_to :mallet_run
  
  after_initialize :init
  def init
    options[:n] ||= 2
    self.name = "First #{options[:n]} Topics"
  end

  def run
    lda_post_tags.delete_all
    
    mallet_run.dataset.posts.each do |post|
      difference = false
      post.lda_post_topics.order("weight desc").limit( options[:n] + 1).reverse.each_cons(2) do |lda_post_topic_2, lda_post_topic_1|
        difference ||= (lda_post_topic_2.weight < lda_post_topic_1.weight)
        if difference
          lda_post_tags.create( :lda_topic_id => lda_post_topic_1.lda_topic_id, :post => post)
        end
      end
    end
    nil
  end
  
end
