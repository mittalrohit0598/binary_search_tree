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
    if root.nil?
      return Node.new(value)
    elsif value < root.data
      root.left_child = insert(value, root.left_child)
    elsif value > root.data
      root.right_child = insert(value, root.right_child)
    elsif value == root.data
      return
    end
    root
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
