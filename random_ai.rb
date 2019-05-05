require_relative 'base_player'

class RandomAI < BasePLayer
  DELAY = 1

  def initialize(team, rules)
    super(team, rules)
  end
  
  def get_move(state)
    actions = possibles_moves(state)
    sleep DELAY
    actions[Random.rand(0...actions.size)]
  end
end