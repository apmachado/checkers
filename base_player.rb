class BasePLayer
  
  attr_accessor :team, :rules

  def initialize(team, rules)
    @team = team
    @rules = rules
  end
  
  # metodo deve ser iplementado nas classes filhas
  # se humano pega um input do usuario
  # se IA executa o agoritmo de busca
  def get_move(state)
    throw "Método ainda não implementato."
  end

  # retorna as coordenadas/indices das pecas deste jogador
  def pieces(state)
    pieces = []
    state.table.each_with_index do |line, i|
      c = line.each_with_index.map do |e, j|
        [i, j] if rules.piece_team(e)
      end
      c.compact!
      pieces.concat(c) unless c.empty?
    end
    pieces
  end

  # retorna todas as possiveis jogadas deste jogador
  # no estado passado
  def possibles_moves(state)
    actions = []
    pieces(state).each do |piece|
      e = moves_by_piece(state, piece)
      actions.concat(e) unless e.empty?
    end
    actions
  end

  # retorna todos os movimentos que uma peca pode fazer
  def moves_by_piece(state, piece)
    actions = []
    # faz a compinacao da peca com toda coordeanda do tabuleiro
    (0...8).each do |i|
      a = (0...8).each.map { |j| [piece[0], piece[1], i, j] }
      actions.concat(a)
    end
    # retorna apenas as jogadas validas
    actions = actions.select { |a| rules.validate_action(state, a).nil? }
  end
end