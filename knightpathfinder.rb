class KnightPathfinder

POSSIBLE_MOVES = [[ 2, -1], [ 2, 1],  # ꓶ Γ
                  [-2, -1], [-2, 1],  # ⅃ L
                  [-1, -2], [-1, 2],  # __| |__
                  [ 1, -2], [ 1, 2]]  # --| |--
                  
  def self.valid_moves(pos)
    potential_moves = POSSIBLE_MOVES.map do |row|
      row.map.with_index do |col, i|
          col + pos[i]
      end
    end
    potential_moves.select{ |pos| pos.all? { |coord| coord.between?(0, 7) } }
  end

  attr_reader :start_pos

  def initialize(start_pos)
    @start_pos = start_pos
    @considered_positions = [start_pos]

    build_move_tree
  end

  private 

  attr_accessor :considered_positions

  def build_move_tree
    self.root_node = PolyTreeNode.new(start_pos)
  end

  def new_move_positions(pos)
    KnightPathfinder.valid_moves(pos)
    .reject{ |new_pos| considered_positions.include?(pos) }
    .each { |new_pos| considered_positions << new_pos }
  end
end
