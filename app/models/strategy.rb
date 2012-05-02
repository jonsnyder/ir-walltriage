class Strategy < ActiveRecord::Base

  has_many :lda_post_tags
  
  serialize :options, Hash
end
