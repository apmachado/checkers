require_relative 'base_player'

class MinMaxAlphaBeta < BasePLayer
  attr_accessor :actions_stack, :result_action

  #  mais e menos infinito
  FIXNUM_MAX = (2**(0.size * 8 -2) -1)
  FIXNUM_MIN = -(2**(0.size * 8 -2))

  def initialize(team, rules)
    @actions_stack = []   # pinha usada para a busca
    @result_action = []   # variável global que guardara a acao escolhida pela busca
    super(team, rules)
  end

  # chama o min_max passando as condicoes iniciais para devolver a acao
  def get_move(state)
    value = min_max(state, FIXNUM_MIN, FIXNUM_MAX, true)
    result_action
  end

  # min max com poda alpha beta
  # o paramentro 'first' eh usado para saber qual foi a primeira chamado do min_max
  # apenas a primeira chamado guardara a acao
  def min_max(state, alpah, beta, first = false)
    # se achar uma folha retorna a funcao de utilidade
    return utility(state) if rules.has_ended?(state)

    # escolhe ou min ou max dependendo de quem eh a vez
    (state.turn == team) ?
      max_value(state, alpah, beta, first) :
      min_value(state, alpah, beta, first)
  end

  def max_value(state, alpha, beta, first)
    value = FIXNUM_MIN
    # emplilha as jogadoas a serem analisadas
    actions_stack << possibles_moves(state)
    actions_stack.last.each do |action|
      # pega o novo estado a partir da acao corrente
      next_state = rules.apply_action(state, action)
      v = min_max(next_state, alpha, beta)
      if v > value
        value = v
        # se eh a primeira chamada da funcao salva a melhor acao no momento
        @result_action = action if first
      end
      if value >= beta
        actions_stack.pop
        return value
      end

      alpha = max(alpha, value)
    end
    # desempilha o conjuto de acoes vindas do estado
    actions_stack.pop
    value
  end

  def min_value(state, alpha, beta, first)
    value = FIXNUM_MAX
     # emplilha as jogadoas a serem analisadas
    actions_stack << possibles_moves(state)
    actions_stack.last.each do |action|
      # pega o novo estado a partir da acao corrente
      next_state = rules.apply_action(state, action)
      v = min_max(next_state, alpha, beta)
      if v < value
        value = v
        # se eh a primeira chamada da funcao salva a melhor acao no momento
        @result_action = action if first
      end
      if value <= alpha
        actions_stack.pop
        return value
      end

      beta = min(beta, value)
    end
    # desempilha o conjuto de acoes vindas do estado
    actions_stack.pop
    value
  end

  # funcao de utilidade
  # 0 para empate; -1 para derrota; 1 para vitoria
  def utility(state)
    return 0 if rules.draw?(state)

    (state.turn == team) ? -1 : 1 
  end

  def min (a, b)
    (a < b) ? a : b
  end

  def max (a, b)
    (a > b) ? a : b
  end
end

