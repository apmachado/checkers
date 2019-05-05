class BasePLayer
  
  attr_accessor :team, :rules

  def initialize(team, rules)
    @team = team
    @rules = rules
  end
  
  def get_move(state)
    throw "Método ainda não implementato."
  end

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

  def possibles_moves(state)
    actions = []
    pieces(state).each do |piece|
      e = moves_by_piece(state, piece)
      actions.concat(e) unless e.empty?
    end
    actions
  end

  def moves_by_piece(state, piece)
    actions = []
    (0...8).each do |i|
      a = (0...8).each.map { |j| [piece[0], piece[1], i, j] }
      actions.concat(a)
    end
    actions = actions.select { |a| rules.validate_action(state, a).nil? }
  end
end