require_relative 'state'

class GameController
  attr_accessor :state

  def initialize(player_1, player_2)
    @state = State.new(player_1)
  end

  def run_game
    draw
  end

  def draw
    top_edge = "\u2581"
    botton_edge = "\u2594"
    frame_edge = "\u2550"

    print "  \u2554#{frame_edge * 28}\u2557"
    print "\n  \u2551  #{top_edge * 24}  \u2551\n"
    state.table.each do |line|
      print "  \u2551 \u2595"
      line.each do |cell|
        if cell == -1
          print "\u2588\u2588\u2588"
        elsif cell == 0
          print '   '
        elsif cell == 1
          print ' X '
        elsif cell == 2
          print ' 0 '
        end
      end
      print "\u258F \u2551\n"
    end
    print "  \u2551  #{botton_edge * 24}  \u2551\n"
    print "  \u255A#{frame_edge * 28}\u255D\n"
  end
end
