require_relative 'base_player'

class CutOffWeighted < BasePLayer
  attr_accessor :actions_stack, :result_action

  FIXNUM_MAX = (2**(0.size * 8 -2) -1)
  FIXNUM_MIN = -(2**(0.size * 8 -2))
  DEPTH = 5

  def initialize(team, rules)
    @actions_stack = []
    @result_action = []
    super(team, rules)
  end

  def get_move(state)
    value = min_max(state, FIXNUM_MIN, FIXNUM_MAX, 0, true)
    result_action
  end

  def min_max(state, alpha, beta, depth, first = false)
    return eval(state) if cut_off?(depth) || rules.has_ended?(state)

    (state.turn == team) ?
      max_value(state, alpha, beta, depth, first) :
      min_value(state, alpha, beta, depth, first)
  end

  def max_value(state, alpha, beta, depth, first)
    value = FIXNUM_MIN
    actions_stack << possibles_moves(state)
    actions_stack.last.each do |action|
      next_state = rules.apply_action(state, action)
      v = min_max(next_state, alpha, beta, depth + 1)
      if v > value || (v==value && next_state.total_pieces < state.total_pieces)
        value = v
        @result_action = action if first
      end
      if value >= beta
        actions_stack.pop
        return value
      end

      alpha = max(alpha, value)
    end
    actions_stack.pop
    value
  end

  def min_value(state, alpha, beta, depth, first)
    value = FIXNUM_MAX
    actions_stack << possibles_moves(state)
    actions_stack.last.each do |action|
      next_state = rules.apply_action(state, action)
      v = min_max(next_state, alpha, beta, depth + 1)
      if v < value
        value = v
        @result_action = action if first
      end
      if value <= alpha
        actions_stack.pop
        return value
      end

      beta = min(beta, value)
    end
    actions_stack.pop
    value
  end

  def eval(state)
    factor = (team == 1) ? 1 : -1
    if state.total_pieces > 12
      ((state.kings_player1*2 + (state.pieces_player1 - state.kings_player1)) - (state.kings_player2*2 + (state.pieces_player2 - state.kings_player2)))*factor

    else
      value1, value2 = 0, 0
      kings_weights = [0, 4, 3, 2, 1]
      position = [ [0, 4, -1, 4, -1, 4, -1, 4],
                   [4, -1, 3, -1, 3, -1, 3, 0],
                   [4, 3, -1, 2, -1, 2, -1, 4],
                   [4, -1, 2, -1, 1, -1, 3, 0],
                   [0, 3, -1, 1, -1, 2, -1, 4],
                   [1, -1, 2, -1, 2, -1, 3, 0],
                   [4, 3, -1, 3, -1, 3, -1, 4],
                   [4, -1, 4, -1, 4, -1, 4, 0]]
        i = 0
        while i < 8 do

          j = 0
          while j < 8 do
            if state.table[i][j] == 1
              value1 += 5*position[i][j]
            end

            if state.table[i][j] == 3
              value1 += 15*kings_weights[position[i][j]]
            end

            if state.table[i][j] == 2
              value2 += 5*position[i][j]
            end

            if state.table[i][j] == 4
              value2 += 15*kings_weights[position[i][j]]
            end
            j += 1
          end
          i += 1
        end


      value1 = FIXNUM_MAX if (value2== 0) || (rules.table_stuck(state) && state.turn==2)
      value2 = FIXNUM_MAX if (value1 == 0) || (rules.table_stuck(state) && state.turn== 1)

      (value1 - value2)*factor
    end
  end

  def cut_off?(depth)
    depth >= DEPTH
  end

  def min (a, b)
    (a < b) ? a : b
  end

  def max (a, b)
    (a > b) ? a : b
  end

end

