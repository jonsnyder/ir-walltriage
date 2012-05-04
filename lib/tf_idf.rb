class TfIdf
  extends ActiveSupport::Memoizable
  
  def initialize( doc_freq, docs)
    @doc_freq = doc_freq
    @docs = docs
    @freq = WordFrequency.new
  end

  def add( word)
    @freq.add(word)
  end

  def freq( word)
    @freq.freq(word)
  end
  
  def tf_idf( word)
    @freq.freq(word) * Math.log( @docs / @doc_freq.freq( word))
  end
  memoize :tf_idf
  
  def dot_product( other)
    sum = 0.0
    @freq.words.each do |word|
      if other.freq(word) != 0
        sum += tf_idf(word) * other.tf_idf(word)
      end
    end
  end

  def squared
    sum = 0.0
    @freq.words.each do |word|
      sum += @freq.tf_idf( word)**2
    end
  end
  memoize :squared

  def cosine_sim( other)
    dot_product(other) / (squared * other.squared)
  end
end
