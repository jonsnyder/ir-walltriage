class DelayedJob < Struct.new( :id, :klass, :method, :params)
  def perform
    klass.constantize.find(id).send(method, *params)
  end
end
