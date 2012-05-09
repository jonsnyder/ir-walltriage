class CosineSimularity
  
  def initialize( tf_idfs, matcher)
    @tf_idfs = tf_idfs
    @matcher = matcher
  end
  
  def calculate
    sum_of_intra = 0.0
    count_of_same = 0
    
    sum_of_inter = 0.0
    count_of_diff = 0

    (0..@tf_idfs.size-2).each do |i|
      (i+1..@tf_idfs.size-1).each do |ii|

        simularity = @tf_idfs[i].cosine_sim( @tf_idfs[ii])
        # puts "#{@tf_idfs[i].id} - #{@tf_idfs[ii].id}"
        if !simularity.nan?
          if @matcher.matches?( @tf_idfs[i].id, @tf_idfs[ii].id)
            sum_of_intra += simularity
            count_of_same += 1
          else
            sum_of_inter += simularity
            count_of_diff += 1
          end
        end
      end
    end

    [sum_of_intra / count_of_same, sum_of_inter / count_of_diff]
  end
end
        
    
