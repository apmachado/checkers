require_relative 'base_player'

class RandomAI < BasePLayer
  DELAY = 0.5

  def initialize(team, rules)
    super(team, rules)
  end
  
  def get_move(state)
    actions = possibles_moves(state)
    sleep DELAY

    # scolhe uma jogada aleatoria a partir das possiveis acoes
    actions[Random.rand(0...actions.size)]
  end
end