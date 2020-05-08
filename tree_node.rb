class PolyTreeNode
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end
  
  def parent
    @parent
  end

  def children
    @children.dup
  end

  def value
    @value
  end

  def parent=(parent)
    return if self.parent == parent

    #detach old parents
    self.parent._children.delete(self) if self.parent

    @parent = parent
    self.parent._children << self unless self.parent.nil?

    self
  end

  def add_child(child)
    child.parent = self
  end

  def remove_child(child)
    if child && !self.children.include?(child)
      raise "Tried to remove node that isn't a child."
    end

    child.parent = nil
  end

  def dfs(target_value)
    #check value at this node, return if value matches
    return self if @value == target_value

    #iterate through children
    self.children.each do |child|
      #check if target exists within children
      search = child.dfs(target_value)
      #return the path if found
      return search unless search.nil?
    end
    #return nil if value is not found
    nil
  end

  def bfs(target_value)
    #local array, insert current node into queue
    queue = [self]

    #loop runs until array is empty
    until queue.empty?
      #remove the first node and check the value. 
      node = queue.shift
      #Return node if value matches
      return node if node.value == target_value

      #push the node's children to the end of the array
      queue.concat(node.children)
    end
    #return nil if not found
    nil
  end

  def inspect
    { 'value' => value, 'parent' => parent, 'children' => children }.inspect
  end

  protected

  def _children
    @children
  end
end