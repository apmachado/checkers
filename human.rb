require_relative 'base_player'

class Human < BasePLayer

  def initialize(team, rules)
    super(team, rules)
  end

  def generate_action(input)
    coord_x = {'A'=>1, 'B'=>2, 'C'=>3, 'D'=>4, 'E'=>5, 'F'=>6, 'G'=>7, 'H'=>8}
    coord_y = {'1'=>1, '2'=>2, '3'=>3, '4'=>4, '5'=>5, '6'=>6, '7'=>7, '8'=>8}

    coords = [coord_x[input[0]], coord_y[input[1]], coord_x[input[2]], coord_y[input[3]]]
    coords.map { |x| x - 1}
  end
  
  def get_move(state)
    action = []
    valid_pos = false
    
    while (!valid_pos) do
      puts "Escolha a peça e a posição que deseja mover"
      input = gets.upcase.split(/[\s,']/)#.map { |s| s.to_i }
      if(!((input[1].to_i.between?(1,8))&& (input[3].to_i.between?(1,8)) && (input[0] =~ /[A-H]/) && (input[2] =~ /[A-H]/)))
        puts "Posicao invalida"
      else
        action = generate_action(input)
        result = rules.validate_action(state, action)
        if !result.nil?
          puts result
          valid_pos = false
        else
          valid_pos = true
        end
      end
    end
    action
  end
end