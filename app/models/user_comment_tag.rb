class UserCommentTag < ActiveRecord::Base
  belongs_to :post
  belongs_to :access_token

  scope :user, lambda { |user| where( :access_token_id => user.id) }
end
