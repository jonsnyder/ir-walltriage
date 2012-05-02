class LdaPostTopic < ActiveRecord::Base
  belongs_to :post
  belongs_to :lda_topic
end
