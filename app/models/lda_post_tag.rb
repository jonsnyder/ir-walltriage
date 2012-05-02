class LdaPostTag < ActiveRecord::Base
  belongs_to :post
  belongs_to :lda_topic
  belongs_to :strategy
end
