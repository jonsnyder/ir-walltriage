class Matcher::Test

  def initialize( matches)
    @matches = matches
  end
  
  def matches?( a, b)
    @matches[a][b]
  end  
end
