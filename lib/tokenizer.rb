module Tokenizer

  def self.scan( content)
    if content.nil?
      return
    end

    content.gsub!(/\.\.+/,' ')
    content.gsub!(/(\w\w)-(\w\w)/, "\\1 - \\2")
    content.scan(/\$?\b\S+\b%?|[?!]/) do |word|
        case word
        when /^https?:\/\/|^www\.|\.com/
          yield "[url]"
        when /^\$/
          yield "[money]"
        when /\d\.\d\d$/
          yield "[money]"
        when /^[\d]+(\.\d+)?%$/
          yield "[percent]"
        when /^[\d]+(\.\d+)?$/
          yield "[number]"
        else
          word = word.downcase
          word = word.gsub(/'/,'')
          yield word
        end
    end
  end
end
