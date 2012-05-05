class DelayedJob < Struct.new( :id, :klass, :method)
  def perform
    klass.constantize.find(id).send(method)
  end
end
