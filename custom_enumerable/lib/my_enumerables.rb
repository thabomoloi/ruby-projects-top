module Enumerable # rubocop:disable Style/Documentation
  def my_each_with_index
    idx = 0
    my_each do |element|
      yield element, idx
      idx += 1
    end
  end

  def my_select
    selected = []
    my_each { |element| selected.push(element) if yield(element) }
    selected
  end

  def my_all?
    my_each { |element| return false unless yield(element) }
    true
  end

  def my_any?
    my_each { |element| return true if yield(element) }
    false
  end

  def my_none?
    my_each { |element| return false if yield(element) }
    true
  end

  def my_count
    count = 0
    my_each { |element| count += 1 if (block_given? && yield(element)) || !block_given? }
    count
  end

  def my_map
    mapped = []
    my_each { |element| mapped.push(yield(element)) }
    mapped
  end

  def my_inject(result = self[0])
    start_idx = result == self[0] ? 1 : 0
    self[start_idx..].my_each { |element| result = yield(result, element) }
    result
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  def my_each
    length.times { |i| yield self[i] }
    self
  end
end
