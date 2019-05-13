require_relative 'base_player'

class CutOff < BasePLayer
  attr_accessor :actions_stack, :result_action

  FIXNUM_MAX = (2**(0.size * 8 -2) -1)
  FIXNUM_MIN = -(2**(0.size * 8 -2))
  DEPTH = 4

  def initialize(team, rules)
    @actions_stack = []
    @result_action = []
    super(team, rules)
  end

  def get_move(state)
    value = min_max(state, FIXNUM_MIN, FIXNUM_MAX, 0, true)
    result_action.sample
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
      if v > value
        value = v
        @result_action = [action] if first
      elsif v == value
        @result_action.push(action) if first
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
        @result_action = [action] if first
      elsif v == value
        @result_action.push(action) if first
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

    (state.pieces_player1 - state.pieces_player2) * factor
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

