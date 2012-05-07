class Stat < ActiveRecord::Base
  
  serialize :options, Hash

  has_many :stat_values, :dependent => :destroy

  class << self
    extend ActiveSupport::Memoizable

    def kappa
      where(:name => "Kappa").first
    end
    memoize :kappa

    def precision
      where(:name => "Precision").first
    end
    memoize :precision

    def recall
      where(:name => "Recall").first
    end
    memoize :recall

    def cosine_simularity
      where(:name => "Cosine Simularity").first
    end
    memoize :cosine_simularity

  end
end
