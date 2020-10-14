# frozen_string_literal: true

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

  def inorder(node = root, array = [])
    return array if node.nil?

    inorder(node.left_child, array)
    array << node.data
    inorder(node.right_child, array)

    array
  end

  def preorder(node = root, array = [])
    return array if node.nil?

    array << node.data
    preorder(node.left_child, array)
    preorder(node.right_child, array)

    array
  end

  def postorder(node = root, array = [])
    return array if node.nil?

    postorder(node.left_child, array)
    postorder(node.right_child, array)
    array << node.data

    array
  end

  def height(node = root)
    return -1 if node.nil?

    left_height = height(node.left_child)
    right_height = height(node.right_child)

    return left_height + 1 if left_height > right_height

    right_height + 1
  end

  def depth(node, root = self.root)
    return -1 if node.nil?

    if node.data < root.data
      depth = depth(node, root.left_child)
    elsif node.data > root.data
      depth = depth(node, root.right_child)
    else
      return 0
    end

    depth + 1
  end

  def balanced?(node = root)
    return true if node.nil?
    return false if (height(node.left_child) - height(node.right_child)).abs > 1

    left_balanced = balanced?(node.left_child)
    right_balanced = balanced?(node.right_child)

    return false if left_balanced == false || right_balanced == false

    true
  end

  def rebalance
    tree = level_order_recursion
    self.root = build_tree(tree.sort)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end
