class Human
  
  attr_accessor :team

  def initialize(team)
    @team = team
  end
  
  def get_move(matrix)
    if self.team == "white"
      coord = {A:0, B:1, C:2, D:3, E:4, F:5, G:6, H:7}
    else
      coord = {A:7, B:6, C:5, D:4, E:3, F:2, G:1, H:0}
    end
    
    puts "Escolha a peça e a posição que deseja mover"
    input = gets.split(/[\s,']/)#.map { |s| s.to_i }
    puts coord.input[0]
  end
end

matrix = [[-1, 2, -1, 2, -1, 2, -1, 2],
              
          [2, -1, 2, -1, 2, -1, 2, -1],

          [-1, 2, -1, 2, -1, 2, -1, 2],

          [0, -1, 0, -1, 0, -1, 0, -1],

          [-1, 0, -1, 0, -1, 0, -1, 0],

          [1, -1, 1, -1, 1, -1, 1, -1],

          [-1, 1, -1, 1, -1, 1, -1, 1],

          [1, -1, 1, -1, 1, -1, 1, -1]]

test = Human.new("white")
test.get_move(matrix)