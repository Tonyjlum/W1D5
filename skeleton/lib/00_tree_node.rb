require 'byebug'
class PolyTreeNode
  attr_reader :value, :children, :parent

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  # def parent
  #   self.parent
  # end
  #
  # def children
  #   self.children
  # end
  #
  # def value
  #   self.value
  # end

  def parent=(parent_node)
    self.parent.children.delete(self) unless self.parent.nil?
    @parent = parent_node
    parent_node.children << self unless parent_node.nil? || parent_node.children.include?(self)
  end

  def add_child(child_node)
    child_node.parent=(self)
  end

  def remove_child(child_node)
    raise "Node is not a child" unless self.children.include?(child_node)
    child_node.parent=(nil)
  end

  def dfs(target_value)
    return self if self.value == target_value
    # return nil if self.children.empty?

    self.children.each do |child|
      recursive_call = child.dfs(target_value)
      return recursive_call unless recursive_call.nil?


    end
    #recursively check each self, then first child until child
    #either == target or == nil, then check next
    # for i in (0...stack.length) do
    # recursive_call = child.dfs(target_value)
    # return recursive_call unless recursive_call.nil?
    # end


    nil
  end

  # def bfs(target_value)
  #   return self if self.value == target_value
  #   return nil if self.children.empty?
  #
  #   queue = self.children
  #
  #   queue.each do |child|
  #     return child if child.value == target_value
  #   end
  #
  #   for i in (0...queue.length) do
  #     recursive_call = queue[i].bfs(target_value)
  #     return recursive_call if recursive_call != nil && recursive_call.value == target_value
  #   end
  #   nil
  # end

  def bfs(target_value)
    queue = []
    queue << self

    until queue.empty?
      current = queue.shift
      return current if current.value == target_value
      queue += current.children
    end
    nil
  end
end
