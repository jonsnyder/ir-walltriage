class CollapsingGrid

  def initialize( rows)
    @rows = rows.group_by { |stat_value| stat_value.strategy.mallet_run.name }
    @rows.each do |name, stat_values|
      @rows[name] = [stat_values.first.strategy.mallet_run.perplexity, MalletRunGroup.new( stat_values)]
    end
  end

  def rows
    @rows.each do |name, (perplexity, mallet_run_group)|
      first = true
      mallet_run_group.rows do |row|
        if first
          yield [[name, mallet_run_group.row_count], [perplexity, mallet_run_group.row_count]] + row
          first = false
        else
          yield row
        end
      end
    end
  end
end

class MalletRunGroup

  def initialize( rows)
    @rows = rows.group_by { |stat_value| stat_value.strategy.name }
    @rows.each do |name, stat_values|
      user_group = UserGroup.new( stat_values.select { |stat_value| stat_value.access_token_id } )
      cosine_sim = stat_values.find { |stat_value| stat_value.stat_id == Stat.cosine_simularity }
      @rows[name] = [user_group, cosine_sim]
    end
  end

  def row_count
    @rows.values.map { |user_group, cosine_sim| user_group.row_count}.reduce(0) { |sum,count| sum + count }
  end

  def rows
    
    @rows.each do |name, (user_group,cosine_sim)|
      first = true
      user_group.rows do |row|
        if first
          yield [ [ name, user_group.row_count], [cosine_sim && cosine_sim.value, user_group.row_count ]] + row
          first = false
        else
          yield row
        end
      end
    end
  end
                  
  
end

class UserGroup

  def initialize( rows)
    @rows = rows.group_by { |stat_value| stat_value.access_token.name }
  end

  def row_count
    @rows.size + 1
  end

  def rows
    kappa_sum = 0.0
    precision_sum = 0.0
    recall_sum = 0.0
    
    
    @rows.each do |name, stats|
      stats_by_id = stats.group_by { |stat_value| stat_value.stat_id}

      kappa_sum += stats_by_id[ Stat.kappa.id].first.value
      precision_sum += stats_by_id[ Stat.precision.id].first.value
      recall_sum += stats_by_id[ Stat.recall.id].first.value
      
      yield [
             name,
             stats_by_id[ Stat.kappa.id].first.value,
             stats_by_id[ Stat.precision.id].first.value,
             stats_by_id[ Stat.recall.id].first.value,
            ]
    end

    yield [
           "Total",
           kappa_sum / @rows.size,
           precision_sum / @rows.size,
           recall_sum / @rows.size,
          ]
  end
end
  
