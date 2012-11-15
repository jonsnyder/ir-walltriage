class Sentence
  
  def initialize( index, data)
    @index = index
    @data = data
    @topics = WordFrequency.new
    @words = 0
  end

  def raw
    @data["split"][@index]
  end

  def data
    @data
  end
  
  def tokenized( stopword_list)
    Tokenizer.scan( raw) do |word|
      if !stopword_list.contains( word)
        @words += 1
        yield word
      end
    end
  end

  def add_topic( topic)
    @topics.add(topic)
  end

  def score( topic)
    return 0 if @words == 0
    @topics.freq( topic).to_f / @words
  end

  def all_scores
    @topics.words.each do |topic|
      puts "#{topic.id.to_s} #{score(topic)}"
    end
  end 
  
end
