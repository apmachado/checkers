class State
  
  attr_accessor :table, :turn, :mans_p1, :mans_p2, 
                :kings_p1, :kings_p2, 
                :turns_without_promotion, :turns_without_points  
  
  def initialize(initial_player)
    
    @table = [[-1, 2, -1, 2, -1, 2, -1, 2],
              
              [2, -1, 2, -1, 2, -1, 2, -1],
              
              [-1, 2, -1, 2, -1, 2, -1, 2],
              
              [0, -1, 0, -1, 0, -1, 0, -1],
              
              [-1, 0, -1, 0, -1, 0, -1, 0],
              
              [1, -1, 1, -1, 1, -1, 1, -1],
              
              [-1, 1, -1, 1, -1, 1, -1, 1],
              
              [1, -1, 1, -1, 1, -1, 1, -1]]
    
    @turn = initial_player
    @mans_p1 = 12
    @mans_p2 = 12
    @kings_p1 = 0
    @kings_p2 = 0
    turns_without_promotion = 0
    turns_without_points = 0
  
  end

  def copy_state()
    
    self.dup()

  end
end