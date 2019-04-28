require_relative 'state'
require_relative 'display'

class GameController
  attr_accessor :state

  def initialize(player_1, player_2)
    @state = State.new(player_1)
    @display = Display.new
  end

  def run_game
    @display.set_board state.table
    @display.draw
  end
end
