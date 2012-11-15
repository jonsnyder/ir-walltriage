class Sentence < ActiveRecord::Base
  belongs_to :post
  belongs_to :comment
  belongs_to :stopword_list
end
