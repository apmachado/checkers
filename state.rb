require_relative "piece"
class State
  
  WHITE_MAN = 1
  BLACK_MAN = 2
  WHITE_KING = 3
  BLACK_KING = 4
  attr_accessor :pieces_player1, :pieces_player2, :table, :turn,  
                :turns_without_promotion, :turns_without_points  
  
  def initialize(initial_player)
   
    @pieces_player1 = 0
    @pieces_player2 = 0

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
    p "Turn ", @turn
    p "Turn whitout promotion ", @turns_without_promotion
    p "Turn without points ", @turns_without_points
  end
end

estado = State.new(1)
estado.print_state
