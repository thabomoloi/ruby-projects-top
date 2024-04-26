require_relative 'linked_list'

# Represent a key-value pair
class Entry
  attr_accessor :key, :value

  def initialize(key, value)
    @key = key
    @value = value
  end

  def ==(other)
    @key == other.key
  end

  def pair
    [@key, @value]
  end
end

# Represents a hash map
class HashMap
  def initialize
    @capacity = 16
    @size = 0
    @buckets = Array.new(@capacity) { LinkedList.new }
    @load_factor = 0.8
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = (prime_number * hash_code) + char.ord }
    hash_code % @buckets.length
  end

  def set(key, value)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length
    return update(key, value) if has?(key)

    grow_bucket_list

    entry = Entry.new(key, value)
    @buckets[index].append(entry)
    @size += 1
  end

  def grow_bucket_list
    return unless @size >= @capacity * @load_factor

    new_capacity = @capacity * 2
    @buckets.concat(Array.new(new_capacity - @capacity))
    @capacity = new_capacity
  end

  def update(key, value)
    @buckets.each do |bucket|
      entry = bucket.find { |e| e.key == key }
      entry.value = value if entry
    end
  end

  def get(key)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length

    entry = bucket.find { |e| e.key == key }
    return nil unless entry

    entry.value
  end

  def has?(key)
    @buckets.any? { |bucket| bucket.any? { |entry| entry.key == key } }
  end

  def remove(key)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length

    bucket = @buckets[index]
    entry = bucket.find { |e| e.key == key }
    return nil unless entry

    bucket.remove_at(bucket.find_index(entry))
    @size -= 1
    entry.value
  end

  def length
    @size
  end

  def clear
    @size = 0
    @capacity = 16
    @buckets = Array.new(@capacity) { LinkedList.new }
  end

  def keys
    keys = []
    @buckets.each do |bucket|
      bucket.each { |entry| keys << entry.key }
    end
    keys
  end

  def values
    values = []
    @buckets.each do |bucket|
      bucket.each { |entry| values << entry.value }
    end
    values
  end

  def entries
    entries = []
    @buckets.each do |bucket|
      bucket.each { |entry| entries << entry.pair }
    end
    entries
  end
end
