require_relative "piece"
class State
  
  WHITE_MAN = 1
  BLACK_MAN = 2
  WHITE_KING = 3
  BLACK_KING = 4
  attr_accessor :pieces_player1, :pieces_player2, :kings_player1, :kings_player2, :table, :turn,  
                :turns_without_promotion, :turns_without_points  
  
  def initialize(initial_player)
   
    @pieces_player1 = 0
    @pieces_player2 = 0
    @kings_player1 = 0
    @kings_player2 = 0

    @table=[[-1, 2, -1, 2, -1, 2, -1, 2],
              
          [2, -1, 2, -1, 2, -1, 2, -1],

          [-1, 2, -1, 2, -1, 2, -1, 2],

          [0, -1, 0, -1, 0, -1, 0, -1],

          [-1, 0, -1, 0, -1, 0, -1, 0],

          [1, -1, 1, -1, 1, -1, 1, -1],

          [-1, 1, -1, 1, -1, 1, -1, 1],

          [1, -1, 1, -1, 1, -1, 1, -1]] 

    
    @turn = initial_player
    @turns_without_promotion = 0
    @turns_without_points = 0
  
  end

  def copy_state()
    
    self.dup()

  end
  
  def print_state()
    p "Table"
    @table.each do |r|
      puts "[" + r.each {p| p }.join(", ") + "]"
    end
    p "Turn", @turn
    p "Turn whitout promotion", @turns_without_promotion
    p "Turn without points", @turns_without_points
    p "Pieces player 1", @pieces_player1
    p "Pieces player 2", @pieces_player2
    p "Kings player 1", @kings_player1
    p "Kings player 2", @kings_player2
  end

  def save_state()
    File.open("last_state.txt", "w") do |f|
      #f << "Table\n"
      @table.each do |r|
        f << r.each {p| p }.join(" ") + "\n"
      end
      #f << "Turn\n"
      f << @turn
      f << "\n"#Turn without promotion\n"
      f << @turns_without_promotion
      f << "\n"#Turn without points\n"
      f << @turns_without_points
      f << "\n"
      f << @pieces_player1
      f << "\n"
      f << @pieces_player2
      f << "\n"
      f << @kings_player1
      f << "\n"
      f << @kings_player2
    end  

  end

  def load_state()
    lines = File.open("last_state.txt").to_a
    i = 0
    while i < 8 do
      line = lines.at(i).split(" ")
      j = 0
      while j < 8 do
        @table[i][j] = line[j].to_i
        j += 1
      end
      i += 1
    end
    line = lines.at(8)
    @turn = line.to_i

    line = lines.at(9)
    @turns_without_promotion = line.to_i

    line = lines.at(10)
    @turns_without_points = line.to_i

    line = lines.at(11)
    @pieces_player1 = line.to_i

    line = lines.at(12)
    @pieces_player2 = line.to_i

    line = lines.at(13)
    @kings_player1 = line.to_i

    line = lines.at(14)
    @kings_player2 = line.to_i
  end
end

