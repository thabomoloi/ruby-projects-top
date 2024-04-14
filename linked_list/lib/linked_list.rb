class Node
  attr_accessor :value, :next_node

  def initialize(value, next_node = nil)
    @value = value
    @next_node = next_node
  end

  def to_s
    "( #{@value} ) -> #{next_node ? next_node.to_s : 'nil'}"
  end
end

class LinkedList
  attr_reader :size, :head, :tail

  def initialize
    @size = 0
    @head = nil
    @tail = nil
  end

  def append(value)
    node = Node.new(value)
    if @head.nil?
      @head = node
    else
      @tail.next_node = node
    end
    @tail = node
    @size += 1
    value
  end

  def prepend(value)
    node = Node.new(value, @head)
    @head = node
    @size += 1
    value
  end

  def at(index)
    return nil if index >= size || index < 0

    current = @head
    index.times { current = current.next_node }
    current
  end

  def pop
    return nil if @size.zero?

    current = @head
    item = @tail
    if @size == 1
      @head = nil
      @tail = nil
    else
      size.times { current = current.next_node if current.next_node != @tail }
      current.next_node = nil
      @tail = current
    end
    @size -= 1
    item
  end

  def contains?(value)
    current = @head
    until current.nil?
      if current.value == value
        return true
      end
      current = current.next_node
    end
    false
  end

  def find(value)
    current = @head
    index = 0
    until current.nil?
      if current.value == value
        return index
      end
      current = current.next_node
      index += 1
    end
  end

  def insert_at(value, index)
    return prepend(value) if index.zero?
    return append(value) if index >= @size

    node = Node.new(value)
    current = @head
    (index - 1).times { current = current.next_node }
    node.next_node = current.next_node
    current.next_node = node
    @size += 1
    value
  end

  def remove_at(index)
    return nil if index >= size
    current = @head
    (index - 1).times { current = current.next_node }
    current.next_node = current.next_node.next_node
    @size -= 1
  end

  def to_s
    current = @head
    result = ''
    if current.nil?
      result += 'nil'
    else
      result += current.to_s
    end
  end
end
