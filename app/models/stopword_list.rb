class StopwordList < ActiveRecord::Base
  extend ActiveSupport::Memoizable

  belongs_to :dataset
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

  def add_words( words)
    words.each do |word|
      stopwords.new( :word => word)
    end
  end
end
