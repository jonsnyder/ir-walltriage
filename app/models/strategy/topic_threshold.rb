class Strategy::TopicThreshold < Strategy

  after_initialize :init
  def init
    options[:threshold] ||= 0.095
    self.name = "Topic Threshold (#{options[:threshold]})"
  end


  def run
    lda_post_tags.delete_all

    columns = [:lda_topic_id, :post_id, :strategy_id]
    rows = []
    mallet_run.lda_topics.each do |lda_topic|
      lda_topic.lda_post_topics.each do |lda_post_topic|
        if lda_post_topic.weight > options[:threshold]
          rows << [ lda_topic.id, lda_post_topic.post_id, self.id]
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
  end

  
end
