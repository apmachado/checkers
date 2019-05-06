require_relative 'base_player'

class MinMaxAlphaBeta < BasePLayer
  attr_accessor :states, :actions_stack, :result_action

  FIXNUM_MAX = (2**(0.size * 8 -2) -1)
  FIXNUM_MIN = -(2**(0.size * 8 -2))


  def initialize(team, rules)
    @states = {
      1 => { id: 1, turn: 1, wineer: nil, actions: [ [1, 2, 0], [1, 3, 0], [1, 4, 0] ] },
      2 => { id: 2, turn: 2, wineer: nil, actions: [ [2, 5, 0], [2, 6, 0] ] },
      3 => { id: 3, turn: 2, wineer: nil, actions: [ [3, 7, 0], [1, 8, 0] ] },
      4 => { id: 4, turn: 2, wineer: nil, actions: [ [4, 9, 0], [4, 10, 0] ] },
      5 => { id: 5, turn: 1, wineer: 1, actions: [] },
      6 => { id: 6, turn: 1, wineer: 7, actions: [] },
      7 => { id: 7, turn: 1, wineer: 5, actions: [] },
      8 => { id: 8, turn: 1, wineer: 3, actions: [] },
      9 => { id: 9, turn: 1, wineer: 7, actions: [] },
      10 => { id: 10, turn: 1, wineer: 1, actions: [] }
    }
    @actions_stack = []
    @result_action = []
    super(team, rules)
  end

  def get_move(state)
    alpah_beta_search(states[state])
  end

  def possibles_moves(state)
    state[:actions]
  end

  def alpah_beta_search(state)
    value = min_max(state, FIXNUM_MIN, FIXNUM_MAX, true)
    # actions = possibles_moves(state)
    # action(actions, v)
  end

  def min_max(state, alpah, beta, first = false)
    return utiliry(state) if !state[:wineer].nil? #rules.has_ended?(state)
    #print @result_action, "\n"

    (state[:turn] == team) ?
      max_value(state, alpah, beta, first) :
      min_value(state, alpah, beta, first)
  end

  def max_value(state, alpha, beta, first)
    print "Max: #{state[:id]} => #{state}\n"
    value = FIXNUM_MIN
    actions_stack << possibles_moves(state)
    actions_stack.last.each do |action|
      next_state = states[action[1]] #rules.apply_action(state, action)
      v = min_max(next_state, alpha, beta)
      if v > value
        value = v
        @result_action = action if first
      end
      #value = max(value, min_max(next_state, alpha, beta))
      #print @result_action, "\n"
      if value >= beta
        actions_stack.pop
        return value
      end

      alpha = max(alpha, value)
    end
    #print "Passou por tadas ", @result_action, "\n"
    actions_stack.pop
    value
  end

  def min_value(state, alpha, beta, first)
    print "Min: #{state[:id]} => #{state}\n"
    value = FIXNUM_MAX
    actions_stack << possibles_moves(state)
    actions_stack.last.each do |action|
      next_state = states[action[1]] #rules.apply_action(state, action)
      #print next_state, "\n"
      v = min_max(next_state, alpha, beta)
      if v < value
        value = v
        @result_action = action if first
      end
      #print @result_action, "\n"
      if value <= alpha
        actions_stack.pop
        return value
      end

      beta = min(beta, value)
    end
    #print "Passou por tadas ", @result_action, "\n"
    actions_stack.pop
    value
  end

  def utiliry(state)
    return state[:wineer]
    return 0 if state[:wineer] == 0 #rules.draw?(state)

    (state[:turn] == team) ? -1 : 1  #(state.turn == team) ? -1 : 1 
  end

  def min (a, b)
    (a < b) ? a : b
  end

  def max (a, b)
    (a > b) ? a : b
  end
end

ia = MinMaxAlphaBeta.new(1, nil)
print "Value: #{ia.get_move(1)}, action: #{ia.result_action}\n"