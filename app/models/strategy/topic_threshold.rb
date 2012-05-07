class Strategy::TopicThreshold < Strategy

  after_initialize :init
  def init
    options[:threshold] ||= 0.095
    self.name = "Topic Threshold (#{options[:threshold]})"
  end


  def run
    lda_post_tags.delete_all
    
    mallet_run.lda_topics.each do |lda_topic|
      lda_topic.lda_post_topics.each do |lda_post_topic|
        if lda_post_topic.weight > options[:threshold]
          lda_topic.lda_post_tags.create( :post_id => lda_post_topic.post_id, :strategy_id => self.id)
        end
      end
    end
  end
end
