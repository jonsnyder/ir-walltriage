class DelayedJob < Struct.new( :id, :k, :method, :params)
  def perform
    k = k.to_s.strip.constantize
    k.find(id).send(method, *params)
  end
end

