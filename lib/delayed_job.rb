class DelayedJob < Struct.new( :id, :klass, :method, :params)
  def perform
    if klass.respond_to? :constantize
      klass = klass.constantize
    end
    klass.find(id).send(method, *params)
  end
end
