class DelayedMalletRun < Struct.new( :id, :method, :params)
  def perform
    MalletRun.find( id).send(method, *params)
  end
  
end
