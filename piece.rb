class Piece
  attr_accessor :team, :king
  
  def initialize(team)
    @team = team
    @king = false
    
  end
end