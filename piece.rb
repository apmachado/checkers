class Piece
  attr_accessor :team, :king, :x, :y
  
  def initialize(team, x, y)
    @team = team
    @king = false
    @x = x
    @y = y
  end
end