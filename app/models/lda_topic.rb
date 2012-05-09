class LdaTopic < ActiveRecord::Base
  belongs_to :mallet_run

  has_many :lda_topic_words, :dependent => :delete_all
  has_many :lda_post_topics, :dependent => :delete_all
  has_many :lda_post_tags, :dependent => :delete_all
end
