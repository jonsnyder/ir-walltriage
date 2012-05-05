class WordFrequency

  def initialize

    @freq = Hash.new
    @freq.default = 0
  end

  def add( word)
    @freq[word] += 1
  end

  def freq( word)
    if !@freq.has_key?( word)
      0
    else
      @freq[word]
    end
  end

  def words
    @freq.keys
  end
  
end
