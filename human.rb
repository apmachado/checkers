class Human
  
  attr_accessor :team

  def initialize(team)
    @team = team
  end
  
  def get_move()
    # if team == 2
    #   coord_x = {'A'=>1, 'B'=>2, 'C'=>3, 'D'=>4, 'E'=>5, 'F'=>6, 'G'=>7, 'H'=>8}
    #   coord_y = {'1'=>1, '2'=>2, '3'=>3, '4'=>4, '5'=>5, '6'=>6, '7'=>7, '8'=>8}
    # else
    #   coord_x = {'A'=>8, 'B'=>7, 'C'=>6, 'D'=>5, 'E'=>4, 'F'=>3, 'G'=>2, 'H'=>1}
    #   coord_y = {'1'=>8, '2'=>7, '3'=>6, '4'=>5, '5'=>4, '6'=>3, '7'=>2, '8'=>1}
    # end

    coord_x = {'A'=>1, 'B'=>2, 'C'=>3, 'D'=>4, 'E'=>5, 'F'=>6, 'G'=>7, 'H'=>8}
    coord_y = {'1'=>1, '2'=>2, '3'=>3, '4'=>4, '5'=>5, '6'=>6, '7'=>7, '8'=>8}

    
    puts "Escolha a peça e a posição que deseja mover"
    input = gets.split(/[\s,']/)#.map { |s| s.to_i }

    coords = [coord_x[input[0]], coord_y[input[1]], coord_x[input[2]], coord_y[input[3]]]
    coords.map { |x| x - 1}

  end
end