class TfIdf
  extend ActiveSupport::Memoizable
  
  def initialize( id, doc_freq, docs)
    @id = id
    @doc_freq = doc_freq
    @docs = docs
    @freq = WordFrequency.new
  end

  def id
    @id
  end
  
  def add( word)
    @freq.add(word)
  end

  def freq( word)
    @freq.freq(word)
  end

  def words
    @freq.words
  end

  def tf_idf( word)
    @freq.freq(word) * Math.log( @docs.to_f / @doc_freq.freq( word))
  end
  memoize :tf_idf
  
  def dot_product( other)
    sum = 0.0
    @freq.words.each do |word|
      if other.freq(word) != 0
        sum += tf_idf(word) * other.tf_idf(word)
      end
    end
    sum
  end

  def root_of_sum_of_squares
    sum = 0.0
    @freq.words.each do |word|
      sum += tf_idf( word)**2
    end
    Math.sqrt sum
  end
  memoize :root_of_sum_of_squares

  def cosine_sim( other)
    dot_product(other) / (root_of_sum_of_squares * other.root_of_sum_of_squares)
  end
end
