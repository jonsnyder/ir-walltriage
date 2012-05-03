class FleissKappa

  def initialize( post_ids, matchers)
    @post_ids = post_ids
    @matchers = matchers
  end

  def calculate
    sum_of_p_i = 0.0
    sum_of_matches = 0
    sum_of_no_matches = 0
    match_decisions = 0
    combinations = 0
    num_matchers = @matchers.size
    
    (0..@post_ids.size-1).each do |i|
      (i..@post_ids.size-1).each do |ii|
        combinations += 1
        
        matches = 0
        no_matches = 0
        matchers.each do |matcher|
          match_decisions += 1
          if matcher.matches?( @post_ids[i], @post_ids[ii])
            matches += 1
          else
            no_matches += 1
          end
        end

        p_i = (matches**2 + no_matches**2 - num_matches).to_f / (num_matches**2 - num_matches)
        sum_of_p_i += p_i
        sum_of_matches += matches
        sum_of_no_matches += matches
      end
    end

    p = sum_of_p_i / combinations
    p_e = (sum_of_matches.to_f / match_decisions)**2 + (sum_of_no_matches.to_f / match_decisions)**2

    @kappa = (p - p_e) / (1 - p_e)
  end
end
