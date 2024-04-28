class Node # rubocop:disable Style/Documentation
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def <=>(other)
    @data <=> other.data
  end
end

class Tree # rubocop:disable Style/Documentation, Metrics/ClassLength
  attr_accessor :root

  def initialize(arr)
    @root = build_tree(arr.uniq.sort)
  end

  def build_tree(arr)
    return nil if arr.empty?

    mid = arr.length / 2
    root = Node.new(arr[mid])
    root.left = build_tree(arr[0...mid])
    root.right = build_tree(arr[mid + 1..])

    root
  end

  def insert(value)
    @root = insert_recursive(@root, value)
  end

  def insert_recursive(node, value)
    return Node.new(value) if node.nil?

    if value < node.data
      node.left = insert_recursive(node.left, value)
    elsif value > node.data
      node.right = insert_recursive(node.right, value)
    end

    node
  end

  def delete(value)
    @root = delete_recursive(@root, value)
  end

  def delete_recursive(node, value) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    return node if node.nil?

    if value < node.data
      node.left = delete_recursive(node.left, value)
    elsif value > node.data
      node.right = delete_recursive(node.right, value)
    else
      if node.left.nil?
        return node.right
      elsif node.right.nil?
        return node.left
      end

      temp = min_value_node(node.right)
      node.data = temp.data
      node.right = delete_recursive(node.right, temp.data)
    end

    node
  end

  def min_value_node(node)
    current = node
    current = current.left until current.left.nil?
    current
  end

  def find(value)
    find_recursive(@root, value)
  end

  def find_recursive(node, value)
    return nil if node.nil?
    return node if node.data == value

    if value < node.data
      find_recursive(node.left, value)
    else
      find_recursive(node.right, value)
    end
  end

  def level_order
    return if @root.nil?

    queue = [@root]
    until queue.empty?
      node = queue.shift
      block_given? ? yield(node.data) : (print "#{node.data} ")

      queue.push(node.left) unless node.left.nil?
      queue.push(node.right) unless node.right.nil?
    end
  end

  def inorder(node = @root, &block)
    return if node.nil?

    inorder(node.left, &block)
    block_given? ? yield(node.data) : (print "#{node.data} ")
    inorder(node.right, &block)
  end

  def preorder(node = @root, &block)
    return if node.nil?

    block_given? ? yield(node.data) : (print "#{node.data} ")
    preorder(node.left, &block)
    preorder(node.right, &block)
  end

  def postorder(node = @root, &block)
    return if node.nil?

    postorder(node.left, &block)
    postorder(node.right, &block)
    block_given? ? yield(node.data) : (print "#{node.data} ")
  end

  def height(node = @root)
    return -1 if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)

    [left_height, right_height].max + 1
  end

  def depth(node)
    return 0 if node.nil?

    current = node
    depth = 0

    while current != @root
      depth += 1
      current = find_parent(@root, current)
    end

    depth
  end

  def find_parent(root, node)
    return nil if root.nil? || node.nil?

    if root.left == node || root.right == node
      root
    elsif node.data < root.data
      find_parent(root.left, node)
    else
      find_parent(root.right, node)
    end
  end

  def balanced?
    return true if @root.nil?

    left_height = height(@root.left)
    right_height = height(@root.right)

    (left_height - right_height).abs <= 1
  end

  def rebalance
    nodes = inorder_array
    @root = build_tree(nodes)
  end

  def inorder_array(node = @root, arr = [])
    return if node.nil?

    inorder_array(node.left, arr)
    arr << node.data
    inorder_array(node.right, arr)
    arr
  end
end

if $PROGRAM_NAME == __FILE__
  tree = Tree.new(Array.new(15) { rand(1..100) })
  puts "Is the tree balanced? #{tree.balanced?}"
  puts 'Level order:'
  tree.level_order { |data| print "#{data} " }
  puts "\nPreorder:"
  tree.preorder { |data| print "#{data} " }
  puts "\nPostorder:"
  tree.postorder { |data| print "#{data} " }
  puts "\nInorder:"
  tree.inorder { |data| print "#{data} " }

  puts "\n\nInserting 105, 110, and 115 to unbalance the tree..."
  tree.insert(105)
  tree.insert(110)
  tree.insert(115)
  puts "Is the tree balanced? #{tree.balanced?}"

  puts 'Rebalancing the tree...'
  tree.rebalance
  puts "Is the tree balanced? #{tree.balanced?}"

  puts 'Level order after rebalance:'
  tree.level_order { |data| print "#{data} " }
  puts "\nPreorder after rebalance:"
  tree.preorder { |data| print "#{data} " }
  puts "\nPostorder after rebalance:"
  tree.postorder { |data| print "#{data} " }
  puts "\nInorder after rebalance:"
  tree.inorder { |data| print "#{data} " }
end
