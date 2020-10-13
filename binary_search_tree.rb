# frozen_string_literal: true

# class Node
class Node
  attr_accessor :data, :left_child, :right_child
  def initialize(data)
    @data = data
    @left_child = nil
    @right_child = nil
  end
end

# class Tree
class Tree
  attr_accessor :root
  def initialize(array)
    @root = build_tree(array.uniq.sort)
  end

  def build_tree(array)
    return nil if array.length.zero? || array.nil?

    mid = (array.length - 1) / 2
    root = Node.new(array[mid])

    root.left_child = build_tree(array[0...mid])
    root.right_child = build_tree(array[mid + 1...array.length])

    root
  end

  def insert(value, root = self.root)
    return Node.new(value) if root.nil?

    if value < root.data
      root.left_child = insert(value, root.left_child)
    elsif value > root.data
      root.right_child = insert(value, root.right_child)
    elsif value == root.data
      return root
    end

    root
  end

  def inorder_successor(root)
    root = root.left_child until root.left_child.nil?

    root
  end

  def delete(value, root = self.root)
    return root if root.nil?

    if value < root.data
      root.left_child = delete(value, root.left_child)
    elsif value > root.data
      root.right_child = delete(value, root.right_child)
    else
      return root.right_child if root.left_child.nil?
      return root.left_child if root.right_child.nil?

      temp = inorder_successor(root.right_child)
      root.data = temp.data
      root.right_child = delete(temp.data, root.right_child)
    end
    root
  end

  def find(value, root = self.root)
    return nil if root.nil?

    if value < root.data
      find(value, root.left_child)
    elsif value > root.data
      find(value, root.right_child)
    else
      root
    end
  end

  def level_order_iteration
    queue = [root]
    array = []
    until queue.empty?
      if queue.first.nil?
        queue.shift
        next
      end
      array << queue.first.data
      queue << queue.first.left_child << queue.first.right_child
      queue.shift
    end
    array
  end

  def level_order_recursion(queue = [root], array = [])
    unless queue.first.nil?
      array << queue.first.data
      queue << queue.first.left_child << queue.first.right_child
    end
    queue.shift

    array = level_order_recursion(queue, array) unless queue.empty?

    array
  end

  def inorder(root = self.root, array = [])
    return array if root.nil?

    inorder(root.left_child, array)
    array << root.data
    inorder(root.right_child, array)

    array
  end

  def preorder(root = self.root, array = [])
    return array if root.nil?

    array << root.data
    preorder(root.left_child, array)
    preorder(root.right_child, array)

    array
  end

  def postorder(root = self.root, array = [])
    return array if root.nil?

    postorder(root.left_child, array)
    postorder(root.right_child, array)
    array << root.data

    array
  end

  def height(root = self.root)
    return 0 if root.nil?

    left_height = height(root.left_child)
    right_height = height(root.right_child)

    return left_height + 1 if left_height > right_height

    right_height + 1
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end

array = Array.new(15) { rand(100) }.uniq.sort
tree = Tree.new(array)
tree.pretty_print
15.times { tree.insert(rand(100)) }
tree.pretty_print
puts tree.height