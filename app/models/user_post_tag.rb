class UserPostTag < ActiveRecord::Base
  belongs_to :post
  belongs_to :access_token

  scope :user, lambda { |user| where( :access_token_id => user.id) }
  scope :dataset, lambda { |dataset| includes(:post).where( 'posts.dataset_id' => dataset) }
end
