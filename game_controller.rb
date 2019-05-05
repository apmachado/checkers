require_relative 'state'
require_relative 'display'
require_relative 'human'
require_relative 'rules'
require_relative 'random_ai'

PLAYERS = [
  Human,
  RandomAI
]

class GameController
  attr_accessor :state, :p1, :p2, :rules

  def initialize(p1, p2)
    @rules = Rules.new
    @p1 = PLAYERS[p1].new(1, rules)
    @p2 = PLAYERS[p2].new(2, rules)

    @state = State.new(@p1.team)
    @display = Display.new(@p1, @p2)
  end

  def run_game
    end_game = false
    # game loop
    while !end_game
      @display.draw(state, current_player)

      action = current_player.get_move(state)

      @state = rules.apply_action(state, action)
      end_game = rules.has_ended?(state)
    end

    winner = (rules.draw?(state)) ? nil : adversary
    @display.draw(state, current_player)
    @display.draw_end_game(winner)
  end

  def current_player
    (state.turn == 1) ? p1 : p2
  end

  def adversary
    (state.turn == 1) ? p2 : p1
  end
end
