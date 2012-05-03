class Stat::Kappa < Stat

  after_initialize :init
  def init
    self.name = "Kappa"
  end

  def run( params)
    dataset = Dataset.find(params[:dataset])
    matchers = []
    if params[:user]
      params[:user].each do |user_id|
        matchers << Matcher::UserPostTags.new( user_id)
      end
    end
    if params[:strategy]
      params[:strategy].each do |strategy_id|
        matchers << Matcher::LdaPostTags.new( Strategy.find( strategy_id))
      end
    end
    FleissKappa.new( dataset.post_ids, matchers).calculate
  end
  
end
