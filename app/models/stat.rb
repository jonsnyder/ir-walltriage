class Stat < ActiveRecord::Base
  
  serialize :options, Hash
end
