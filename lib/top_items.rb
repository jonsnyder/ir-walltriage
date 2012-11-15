class TopItems
  include Enumerable

  Item = Struct.new :value, :item

  def initialize( size)
    @size = size
    @items = []
    @worst = nil
  end

  def add( value, item)
    if @items.size == @size
      return if @worst.value > value

      @items.delete @worst
      @worst = @items.min { |a,b| a.value <=> b.value }
    end
      
    item = Item.new value, item
    @items.push item
    @worst = item if @worst.nil? || @worst.value > value
    nil
  end

  def each
    @items.sort_by { |i| -1 * i.value }.each { |i| yield i.value, i.item }
  end
end
