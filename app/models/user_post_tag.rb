class UserPostTag < ActiveRecord::Base
  belongs_to :post
  belongs_to :access_token
end
