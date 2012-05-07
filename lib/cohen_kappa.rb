class CohenKappa

  def initialize( posts, matcher1, matcher2)
    @posts = posts
    @matcher1 = matcher1
    @matcher2 = matcher2
  end

  def calculate
    @stats = {
      true => { true => 0, false => 0},
      false => { true => 0, false => 0}
    }
    @total = 0
    @posts.each do |post_a|
      @posts.each do |post_b|
        if post_a < post_b
          @total += 1
          matcher1_same = @matcher1.matches?( post_a, post_b)
          matcher2_same = @matcher2.matches?( post_a, post_b)
          @stats[matcher1_same][matcher2_same] += 1
        end
      end
    end
  end        
  
  def count( same_category1, same_category2)
    @stats[same_category1][same_category2]
  end
  
  def total
    @total
  end
  
  def score
    pr_a = (count(true,true) + count(false,false)).to_f / @total
    pr_match1 = (count(true,true) + count(true,false)).to_f / @total
    pr_match2 = (count(true,true) + count(false,true)).to_f / @total
    pr_e = (pr_match1 * pr_match2) + ((1-pr_match1)*(1-pr_match2))
    (pr_a - pr_e) / (1 - pr_e)
  end

  def precision
    count(true,true).to_f / (count(true,true) + count(true,false))
  end

  def recall
    count(true,true).to_f / (count(true,true) + count(false,true))
  end
end
