class Comment < ActiveRecord::Base
  belongs_to :post

  def load_from_facebook( comment)
    self.facebook_id = comment["id"]
    self.from_name = comment["from"]["name"]
    self.from_id = comment["from"]["id"]
    self.message = comment["message"]
    self.created_time = comment["timestamp"]
    self.like_count = comment["likes"]
  end

  def to_line
    text = (message && message.gsub(/\s+/," ").strip) || ""
    {id: id, type: "Comment", text: text}.to_json
  end

  def to_tokenized
    ret = []
    Tokenizer.scan( message) do |word|
      if yield word
        ret << word
      end
    end
    ret.join(' ')
  end
  
  
end
