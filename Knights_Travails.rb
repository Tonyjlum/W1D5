require_relative 'skeleton/lib/00_tree_node.rb'

class KnightPathFinder
  attr_reader :grid, :root_node
  attr_accessor :visited_pos

  def initialize(root_node = PolyTreeNode.new(init_pos = [0, 0]))
    @root_node = root_node
    @grid = Array.new(8) {Array.new(8)}
    @visited_pos = [root_node.value]
  end

  def self.valid_moves(pos) #8 possible moves, return [] of valid_moves
    x , y = pos
    result = [[-1, 2], [-2,1], [-2,-1], [-1,-2], [1,-2], [2,-1], [2,1], [1,2]]
    result.map! { |pair| pair[0], pair[1] = (x + pair[0]), (y + pair[1]) }
    result.select { |pair| pair.all? { |el| el >= 0 } && pair.all? { |el| el < 7 } }
  end

  def new_move_pos(pos) #valid_moves - visited_pos
    new_moves = KnightPathFinder.valid_moves(pos) - visited_pos
    self.visited_pos.concat(new_moves)
    new_moves
  end

  # uses new_move_pos, must represetn shortest path BREADTH-FIRST BUILD, queue and FIFO process
  def build_move_tree(start_node = root_node)
    queue = [start_node]

    until queue.empty?
      node = queue.shift
      moves = new_move_pos(node.value)

      moves.each do |pair|
        new_node = PolyTreeNode.new(pair)
        queue << new_node
        new_node.parent = node
      end
    end
  end

  #Uses either DFS or BFS, DFS for now, returns tree node instance containing end_pos
  #can use DFS if target is far away from start point
  #can use BFS if target is close to start point
  #use .abs on each index.
  def find_path(end_pos)
    byebug
    root_node.dfs(end_pos)
  end

  #Use to add prev positions from find_path(end_pos) to arr
  def trace_path_back
  end
end
