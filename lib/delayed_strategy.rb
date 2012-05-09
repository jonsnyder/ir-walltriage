class DelayedStrategy < Struct.new( :id, :method)
  def perform
    Strategy.find( id).send( method)
  end
end
