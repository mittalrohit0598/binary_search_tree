# frozen_string_literal: true

require_relative 'binary_search_tree/node'
require_relative 'binary_search_tree/tree'

array = Array.new(15) { rand(100) }.uniq.sort
tree = Tree.new(array)
puts tree.balanced?
p tree.level_order_recursion
p tree.preorder
p tree.postorder
p tree.inorder
15.times { tree.insert(rand(200)) }
puts tree.balanced?
tree.rebalance
puts tree.balanced?
p tree.level_order_recursion
p tree.preorder
p tree.postorder
p tree.inorder
