class Piece
  attr_accessor :team, :queen
  
  def initialize(team)
    @team = team
    @queen = false
    
  end
end