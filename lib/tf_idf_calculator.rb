class TfIdfCalculator

  def initialize( posts)
    @posts = posts
  end

  def calculate
    doc_freq = WordFrequency.new
    
    @posts.map do |post|
      tf_idf = TfIdf.new post.id, doc_freq, @posts.size
      post.search.split(" ").each do |word|
        if !word.blank?
          tf_idf.add word
        end
      end

      tf_idf.words.each do |word|
        doc_freq.add word
      end

      tf_idf
    end    
  end
  
end
