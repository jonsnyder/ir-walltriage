class DelayedMalletRun < Struct.new( :id, :method_to_call, :params)
  def perform
    MalletRun.find( id).send(method_to_call, *params)
  end
  
end
