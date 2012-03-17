class UserPostTag < ActiveRecord::Base
  belongs_to :post
  belongs_to :access_token

  scope :user, lambda { |user| where( :access_token => user) }
end
