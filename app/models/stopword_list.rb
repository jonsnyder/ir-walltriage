class StopwordList < ActiveRecord::Base
  extend ActiveSupport::Memoizable

  has_many :stopwords

  def word_hash
    hash = {}
    stopwords.each do |stopword|
      hash[stopword.word] = true
    end
    hash.freeze
  end
  memoize :word_hash

  def contains( word)
    word_hash[word]
  end
end
