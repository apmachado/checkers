require_relative 'game_controller'

# classe que desenha o tabuleiro de acordo com o estado
class Display
  attr_accessor  :state, :player

  TOPO_EDGE = "\u2581"
  BOTTON_EDGE = "\u2594"
  FRAME_EDGE = "\u2550"

  BLACK   = '  '
  EMPTY   = "\u2588\u2588"
  P1_CHAR = "\u26C2 "
  P2_CHAR = "\u26C0 "
  P1_KING = "\u26C3 "
  P2_KING = "\u26C1 "

  CHARS = {
    -1 => EMPTY, 0 => BLACK,  1 => P1_CHAR,
    2 =>P2_CHAR, 3 => P1_KING, 4 => P2_KING
  }

  def initialize(p1, p2)
    @p1 = p1
    @p2 = p2
  end

  def draw(state, player)
    @state = state
    @player = player
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

  def draw_end_game(winner)
    if winner.nil?
      print "Jogo terminou com um empate!!!"
    else
      print "P#{winner.team} - #{winner.class} é o vencedor!!!\n"
    end
  end

  private

  def draw_score
    p1_char_time = (state.turn == @p1.team) ? " \u25F7" : '  '
    p2_char_time = (state.turn == @p2.team) ? " \u25F7" : '  '

    print "#{p1_char_time}  P1 - #{@p1.class}:\n"
    print "\t Nº de peças: #{state.pieces_player1}\n"
    print "\t Nº de damas: #{state.kings_player1}\n\n"
    print "#{p2_char_time}  P2 - #{@p2.class}:\n"
    print "\t Nº de peças: #{state.pieces_player2}\n"
    print "\t Nº de damas: #{state.kings_player2}\n\n"
  end

  def index_to_letter(index)
    (index + 65).chr
  end

  def draw_line
    actions = player.possibles_moves state
    state.table.each_with_index do |line, i|
      print "  \u2551  #{index_to_letter i}\u2595"
      line.each_with_index do |cell, j|
        print ((valid?(actions, [i, j])) ? "\u2591\u2591" : CHARS[cell])
      end
      print "\u258F  \u2551\n"
    end
  end

  def valid?(actions, position)
    actions.each do |a|
      return true if a[2] == position[0] && a[3] == position[1]
    end
    false
  end
end