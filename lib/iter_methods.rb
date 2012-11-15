module IterMethods

  protected
  
  def get_enums_from_args(args)
    args.collect { |e| e.is_a?(Enumerator) ? e.dup : e.to_enum }
  end

  def build(y, &block)
    while true
      y << (begin yield; rescue StopIteration; break; end)
    end
  end

  def zip(*args)
    enums = get_enums_from_args args
    Enumerator.new do |y|
      build y do
        enums.collect { |e| e.next }
      end
    end
  end

  def chain(*args)
    enums = get_enums_from_args args
    Enumerator.new do |y|
      enums.each do |e|
        build y do
          e.next
        end
      end
    end
  end

  def multiply(*args)
    enums = get_enums_from_args args
    duped_enums = enums.collect { |e| e.dup }
    Enumerator.new do |y|
      begin
        while true
          y << (begin; enums.collect { |e| e.peek }; rescue StopIteration; break; end )

          index = enums.length - 1
          while true
            begin
              enums[index].next
              enums[index].peek
              break
            rescue StopIteration
              # Some iterator ran out of items.

              # If it was the first iterator, we are done,
              raise if index == 0

              # If it was a different iterator, reset it
              # and then look at the iterator before it.
              enums[index] = duped_enums[index].dup
              index -= 1
            end
          end
        end
      rescue StopIteration
      end
    end
  end

end
