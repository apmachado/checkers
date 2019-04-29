class Rules

  def invalid_coord(action)
    return ((action[0] < 0) || (action[0] > 7) ||
            (action[1] < 0) || (action[1] > 7) ||
            (action[2] < 0) || (action[2] > 7) ||
            (action[3] < 0) || (action[3] > 7))
  end
    
  
  def piece_team(piece)
    if(piece == 1 || piece == 3)
      return 1
    elsif(piece == 2 || piece == 4)
      return 2
    else
      return piece
    end
  end

  def king(piece)
    (piece == 3 || piece == 4)
  end

  def invalid_destination(piece_x, piece_y, dest_x, dest_y, piece)
    if(piece_team(piece) == 1)
      return (((dest_x) != piece_x - 1) || (dest_y - piece_y).abs() != 1)
    else
      return(((dest_x) != piece_x + 1) || (dest_y - piece_y).abs() != 1)
    end
  end
<<<<<<< HEAD
    
  def has_to_eat(state)
    
    state.table.each_with_index do |line, x|
      line.each_with_index do |e, y|
        if(piece_team(e) == state.turn)
          if(can_eat(x, y, state.table))
            return true
          end
        end
      end
    end
    return false
  end

  def can_eat(piece_x, piece_y, table)
    piece = table[piece_x][piece_y]
    x = [-1,1]
    y = [-1,1]
    dest_x = 0
    dest_y = 0
    if(piece_team(piece) == 1)
      if(!king(piece))
        dest_x = piece_x - 1
        (0..1).each do |i|
          dest_y = piece_y + y[i]
          if(piece_team(table[dest_x][dest_y]) == 2)
            if(table[dest_x - 1][dest_y + y[i]] == 0)
              return true
            end
          end
        end
        return false
      end
    else
      if(!king(piece))
        dest_x = piece_x + 1
        (0..1).each do |i|
          dest_y = piece_y + x[i]
          if(piece_team(table[dest_x][dest_y]) == 1)  
            if(table[dest_x + 1 ][dest_y + x[i]] == 0)
              return true
            end
          end
        end
        return false
      end
    end     
  end
  
=======

>>>>>>> 84e784f9ab1caed6f2b33235d4e42a147086923d
  def apply_action(state,action)
    piece_x = action[0]
    piece_y = action[1]
    piece = state.table[piece_x][piece_y]

    dest_x = action[2]
    dest_y = action[3]

    new_state = state.copy_state()

    new_state.table[piece_x][piece_y] = 0
    new_state.table[dest_x][dest_y] = piece
    
    if(state.turn == 1)
      new_state.turn = 2
    else
      new_state.turn = 1
    end
    new_state
  end
  
  def validate_action(state, action)

    

    if(invalid_coord(action))
      return false
    end

    if(has_to_eat(state))
      p("tem que comer")
      return false
    end

    piece_x = action[0]
    piece_y = action[1]
    piece = state.table[piece_x][piece_y]

    dest_x = action[2]
    dest_y = action[3]
    dest = state.table[dest_x][dest_y]

    if(piece_team(piece) != state.turn)
      p("Escolha uma peça válida")
      return false
    end
    
    if(dest != 0)
      p("Mova para uma posição vazia")
      return false
    end

    if(invalid_destination(piece_x, piece_y, dest_x, dest_y, piece))
      p("Mova para uma posição válida")
      return false
    end
    return true
  end

end
