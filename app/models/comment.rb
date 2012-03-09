class Comment < ActiveRecord::Base
  belongs_to :post_id
end
