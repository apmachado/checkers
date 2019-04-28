class Display
  attr_accessor  :state

  TOPO_EDGE = "\u2581"
  BOTTON_EDGE = "\u2594"
  FRAME_EDGE = "\u2550"

  BLACK   = '  '
  EMPTY   = "\u2588\u2588"
  P1_CHAR = "\u26C2 "
  P2_CHAR = "\u26C0 "
  P1_KING = "\u26C1 "
  P2_KING = "\u26C3 "

  CHARS = { -1 => EMPTY, 0 => BLACK,  1 => P1_CHAR, 2 => P2_CHAR, 3 => P1_KING, 4 => P2_KING }

  def draw(state)
    @state = state
    print "=" * 40
    print "\n"

    draw_score

    print "  \u2554#{FRAME_EDGE * 23}\u2557\n"
    print "  \u2551    #{TOPO_EDGE * 16}   \u2551\n"

    draw_line

    print "  \u2551    #{BOTTON_EDGE * 16}   \u2551\n"
    print "  \u2551    1 2 3 4 5 6 7 8    \u2551\n"
    print "  \u255A#{FRAME_EDGE * 23}\u255D\n"
    print "\n\n"
  end

  private

  def draw_score
    if state.turn == 1
      print " \u25F7  P1\n\n"
      print "    P2\n\n"
    else
      print "    P1\n\n"
      print " \u25F7  P2\n\n"
    end
  end

  def index_to_letter(index)
    (index + 65).chr
  end

  def draw_line
    state.table.each_with_index do |line, index|
      print "  \u2551  #{index_to_letter index}\u2595"
      line.each { |cell| print CHARS[cell] }
      print "\u258F  \u2551\n"
    end
  end
end