class LdaTopic < ActiveRecord::Base
  belongs_to :mallet_run

  has_many :lda_topic_words, :dependent => :destroy
  has_many :lda_post_topics, :dependent => :destroy
  has_many :lda_post_tags, :dependent => :destroy
end
