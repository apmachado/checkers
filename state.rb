require_relative "piece"
class State
  
  WHITE_MAN = 1
  BLACK_MAN = 2
  WHITE_KING = 3
  BLACK_KING = 4
  attr_accessor :pieces_player1, :pieces_player2, :table, :turn,  
                :turns_without_promotion, :turns_without_points  
  
  def initialize(initial_player)
   
    @pieces_player1 = []
    @pieces_player2 = []

    @table=[[-1, 2, -1, 2, -1, 2, -1, 2],
              
          [2, -1, 2, -1, 2, -1, 2, -1],

          [-1, 2, -1, 2, -1, 2, -1, 2],

          [0, -1, 0, -1, 0, -1, 0, -1],

          [-1, 0, -1, 0, -1, 0, -1, 0],

          [1, -1, 1, -1, 1, -1, 1, -1],

          [-1, 1, -1, 1, -1, 1, -1, 1],

          [1, -1, 1, -1, 1, -1, 1, -1]] 

    #second player pieces
    piece1 = Piece.new(2, 0, 1)
    @pieces_player2 << piece1

    piece1 = Piece.new(2, 0, 3)
    @pieces_player2 << piece1

    piece1 = Piece.new(2, 0, 5)
    @pieces_player2 << piece1

    piece1 = Piece.new(2, 0, 7)
    @pieces_player2 << piece1


    piece1 = Piece.new(2, 1, 0)
    @pieces_player2 << piece1

    piece1 = Piece.new(2, 1, 2)
    @pieces_player2 << piece1

    piece1 = Piece.new(2, 1, 4)
    @pieces_player2 << piece1

    piece1 = Piece.new(2, 1, 6)
    @pieces_player2 << piece1


    piece1 = Piece.new(2, 2, 1)
    @pieces_player2 << piece1

    piece1 = Piece.new(2, 2, 3)
    @pieces_player2 << piece1

    piece1 = Piece.new(2, 2, 5)
    @pieces_player2 << piece1

    piece1 = Piece.new(2, 2, 7)
    @pieces_player2 << piece1

    #first player pieces    
    piece1 = Piece.new(1, 7, 0)
    @pieces_player1 << piece1

    piece1 = Piece.new(1, 7, 2)
    @pieces_player1 << piece1

    piece1 = Piece.new(1, 7, 4)
    @pieces_player1 << piece1

    piece1 = Piece.new(1, 7, 6)
    @pieces_player1 << piece1


    piece1 = Piece.new(1, 6, 1)
    @pieces_player1 << piece1

    piece1 = Piece.new(1, 6, 3)
    @pieces_player1 << piece1

    piece1 = Piece.new(1, 6, 5)
    @pieces_player1 << piece1

    piece1 = Piece.new(1, 6, 7)
    @pieces_player1 << piece1

    
    piece1 = Piece.new(1, 5, 0)
    @pieces_player1 << piece1

    piece1 = Piece.new(1, 5, 2)
    @pieces_player1 << piece1

    piece1 = Piece.new(1, 5, 4)
    @pieces_player1 << piece1

    piece1 = Piece.new(1, 5, 6)
    @pieces_player1 << piece1

    
    @turn = initial_player
    @turns_without_promotion = 0
    @turns_without_points = 0
  
  end

  def copy_state()
    
    self.dup()

  end
end
