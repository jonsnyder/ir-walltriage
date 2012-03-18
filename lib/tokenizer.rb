module Tokenizer

  def self.scan( content)
    if content.nil?
      return
    end

    content.gsub!(/\.\.\./,' ... ')
    content.gsub!(/(\w\w)-(\w\w)/, "\\1 - \\2")
    content.scan(/\$?\b\S+\b%?|\.\.\.|[?!.]/) do |word|
        case word
        when /^https?:\/\/|^www\.|\.com/
          yield "_url"
        when /^\$/
          yield "_money"
        when /\d\.\d\d$/
          yield "_money"
        when /^[\d]+(\.\d+)?%$/
          yield "_percent"
        when /^[\d]+(\.\d+)?$/
          yield "_number"
        else
          word = word.gsub(/^_+/,"")
          word = word.downcase
          yield word
        end
    end
  end
end
