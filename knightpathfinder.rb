require_relative 'tree_node'

class KnightPathfinder

POSSIBLE_MOVES = [[ 2, -1], [ 2, 1],  # ꓶ Γ
                  [-2, -1], [-2, 1],  # ⅃ L
                  [-1, -2], [-1, 2],  # __| |__
                  [ 1, -2], [ 1, 2]]  # --| |--
                  
  def self.valid_moves(pos)
    valid_moves = []
    cur_x, cur_y = pos
    POSSIBLE_MOVES.each do |(dx, dy)|
      new_pos = [cur_x + dx, cur_y + dy]
      valid_moves << new_pos if new_pos.all? { |coord| coord.between?(0, 7) }
    end
    valid_moves
  end

  attr_reader :start_pos

  def initialize(start_pos)
    @start_pos = start_pos
    @considered_positions = [start_pos]

    build_move_tree
  end
  
  def find_path(end_pos)
    end_node = root_node.bfs(end_pos)

    trace_path_back(end_node)
      .reverse
      .map(&:value)
  end

  private 

  attr_accessor :considered_positions, :root_node

  def build_move_tree
    self.root_node = PolyTreeNode.new(start_pos)

    #build tree using breadth-first
    nodes = [root_node]
    until nodes.empty?
      current_node = nodes.shift

      current_pos = current_node.value
      new_move_positions(current_pos).each do |next_pos|
        next_node = PolyTreeNode.new(next_pos)
        current_node.add_child(next_node)
        nodes << next_node
      end
    end
  end

  def new_move_positions(pos)
    KnightPathfinder.valid_moves(pos)
    .reject{ |new_pos| considered_positions.include?(new_pos) }
    .each { |new_pos| considered_positions << new_pos }
  end

  def trace_path_back(end_node)
    nodes = []
    current_node = end_node
    until current_node.nil?
      nodes << current_node
      current_node = current_node.parent
    end

    nodes
  end
end

