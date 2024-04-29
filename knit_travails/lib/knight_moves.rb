MOVES = [[-2, -1], [-2, 1], [2, -1], [2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2]].freeze

def valid_position?(pos)
  x, y = pos
  x.between?(0, 7) && y.between?(0, 7)
end

def possible_moves(pos)
  MOVES.map do |move|
    new_pos = [move[0] + pos[0], move[1] + pos[1]]
    new_pos if valid_position?(new_pos)
  end.compact
end

def knight_travails(start, target) # rubocop:disable Metrics/MethodLength
  queue = [[start, [start]]]
  visited = { start => true }
  until queue.empty?
    pos, path = queue.shift
    return path if pos == target

    possible_moves(pos).each do |move|
      unless visited[move]
        visited[move] = true
        queue.push([move, path + [move]])
      end
    end
  end
end

def knight_moves(start, target)
  path = knight_travails(start, target)
  puts "You have made it in #{path.size - 1} moves!  Here's your path:\n#{path}"
end
