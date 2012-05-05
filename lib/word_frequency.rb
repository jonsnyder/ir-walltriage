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

  def top_n_words( n)
    @freq.sort_by { |word, freq| -1 * freq }.take(n).map(&:first)
  end

  def words_occuring_more_than_n_times( n)
    words = []
    @freq.each do |word, freq|
      if freq > n
        words << word
      end
    end
    words
  end

  def words_occuring_once
    words = []
    @freq.each do |word, freq|
      if freq == 1
        words << word
      end
    end
    words
  end
end
