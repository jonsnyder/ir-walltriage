class StatValue < ActiveRecord::Base
  belongs_to :stat
  belongs_to :strategy
  belongs_to :access_token
end
