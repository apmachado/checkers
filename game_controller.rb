require_relative 'state'
require_relative 'display'
require_relative 'human'
require_relative 'rules'

class GameController
  attr_accessor :state, :p1, :p2, :rules

  def initialize(p1, p2)
    print "#{p1} vs #{p2}\n"
    @p1 = Human.new(1)
    @p2 = Human.new(2)

    @rules = Rules.new
    @state = State.new(@p1.team)
    @display = Display.new
  end

  def run_game
    # game loop
    while true
      @display.draw(state)

      action = current_player.get_move
      while !rules.validate_action(state, action)
        action = current_player.get_move
      end

      @state = rules.apply_action(state, action)
    end
  end

  def current_player
    (state.turn == 1) ? p1 : p2
  end
end
