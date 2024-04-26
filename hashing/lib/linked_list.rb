# Represents a node for a doubly linked list
class Node
  attr_accessor :value, :prev_node, :next_node

  def initialize(value, prev_node = nil, next_node = nil)
    @value = value
    @prev_node = prev_node
    @next_node = next_node
  end
end

# Represents a doubly linked list
class LinkedList
  include Enumerable

  attr_reader :size, :head, :tail

  def initialize
    @size = 0
    @head = nil
    @tail = nil
  end

  def append(value)
    @size += 1
    node = Node.new(value, @tail, nil)
    @tail&.next_node = node
    @tail = node
    @head = @tail if @head.nil?
    to_a
  end

  def prepend(value)
    @size += 1
    node = Node.new(value, nil, @head)
    @head&.prev_node = node
    @head = node
    @tail = @head if @tail.nil?
    to_a
  end

  def at(index)
    raise IndexError if index >= @size || index.negative?
    raise 'Empty list' if @size.zero?

    current = @head
    index.times { current = current.next_node }
    current.value
  end

  def pop
    remove_last
  end

  def contains?(value)
    current = @head
    until current.nil?
      return true if current.value == value

      current = current.next_node
    end
    false
  end

  def insert_at(value, index)
    raise IndexError if index > @size || index.negative?
    return prepend(value) if index.zero?
    return append(value) if index == @size

    @size += 1
    current = @head
    (index - 1).times { current = current.next_node }
    node = Node.new(value, current, current.next_node)
    current.next_node = node
    to_a
  end

  # Removes and returns the first element from this list.
  def remove_first
    raise 'Empty list' if @size.zero?

    @size -= 1
    element = @head
    @head = @head&.next_node
    @head&.prev_node = nil
    @tail = nil if @size.zero?
    element.value
  end

  # Removes and returns the last element from this list.
  def remove_last
    raise 'Empty list' if @size.zero?

    @size -= 1
    element = @tail
    @tail = @tail.prev_node
    @tail&.next_node = nil
    @head = nil if @size.zero?
    element.value
  end

  # Removes the element at the specified position in this list.
  def remove_at(index)
    raise IndexError if index >= @size || index.negative?
    return remove_first if index.zero?

    @size -= 1
    current = @head
    (index - 1).times { current = current.next_node }
    element = current.next_node
    current.next_node.next_node.prev_node = current
    current.next_node = current.next_node.next_node
    element.value
  end

  def each
    return enum_for(:each) unless block_given?

    current = @head
    until current.nil?
      yield current.value
      current = current.next_node
    end
  end
end
