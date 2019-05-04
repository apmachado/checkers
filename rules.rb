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

  def king_or_not(piece, dest_x)
    if(piece_team(piece) == 1 && dest_x == 0)
      return 3
    end
    if(piece_team(piece) == 2 && dest_x == 7)
      return 4
    end
    return piece
  end

  def invalid_destination(piece_x, piece_y, dest_x, dest_y, piece)
    if(king(piece))
      return ((dest_x - piece_x).abs() != 1 || (dest_y - piece_y).abs() != 1)
    else
      if(piece_team(piece) == 1)
        return (((dest_x) != piece_x - 1) || (dest_y - piece_y).abs() != 1)
      else
        return(((dest_x) != piece_x + 1) || (dest_y - piece_y).abs() != 1)
      end
    end
  end
  
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
          
          if (dest_y > 0 && dest_y < 7)
            if(piece_team(table[dest_x][dest_y]) == 2)
              if(table[piece_x - 2][piece_y + (2*y[i])] == 0)
                return true
              end
            end
          end
        end
        return false
      else
        (0..1).each do |i|
          (0..1).each do |j|
            dest_x = piece_x + x[i]
            dest_y = piece_y + y[j]
            
            if((dest_y > 0) && (dest_y < 7) && (dest_x > 0) && (dest_x < 7))
              if(piece_team(table[dest_x][dest_y]) == 2)
                if(table[piece_x + (2 * x[i])][piece_y + (2 * y[j])] == 0)
                  return true
                end
              end
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
          if (dest_y > 0 && dest_y < 7)
            if(piece_team(table[dest_x][dest_y]) == 1)
                
              if(table[piece_x + 2 ][piece_y + (2*x[i])] == 0)
                return true
              end
            end
          end
        end
        return false
      else
        (0..1).each do |i|
          (0..1).each do |j|
            dest_x = piece_x + x[i]
            dest_y = piece_y + y[j]
            
            if((dest_y > 0) && (dest_y < 7) && (dest_x > 0) && (dest_x < 7))
              p(piece_team(table[dest_x][dest_y])) 
              if(piece_team(table[dest_x][dest_y]) == 1)
                 
                if(table[piece_x + (2 * x[i])][piece_y + (2 * y[j])] == 0)
                  return true
                end
              end
            end
          end
        end
        return false
      end
    end     
  end
  
  def apply_action(state,action)
    piece_x = action[0]
    piece_y = action[1]
    piece = state.table[piece_x][piece_y]

    dest_x = action[2]
    dest_y = action[3]

    new_state = state.copy_state()

    t = state.table.each.map do |line|
      line.each.map { |e| e}
    end
    new_state.table = t
    new_state.table[piece_x][piece_y] = 0
    new_piece = king_or_not(piece, dest_x)
    new_state.table[dest_x][dest_y] = new_piece

    if(king(new_piece))
      if(state.turn == 1)
        new_state.kings_player1 += 1
      else
        new_state.kings_player2 += 1
      end
      new_state.turns_without_promotion = 0
    else
      new_state.turns_without_promotion += 1
    end
    
    
    if(is_eating(piece_x, piece_y, dest_x, dest_y, state.table))
      delta_x = dest_x - piece_x
      delta_y = dest_y - piece_y
      
      new_state.table[piece_x + delta_x/2][piece_y + delta_y/2] = 0
      if(state.turn == 1)
        new_state.pieces_player2 -= 1
        if(king(state.table[piece_x + delta_x/2][piece_y + delta_y/2]))
          new_state.kings_player2 -= 1
        end
      else
        new_state.pieces_player1 -= 1
        if(king(state.table[piece_x + delta_x/2][piece_y + delta_y/2]))
          new_state.kings_player1 -= 1
        end
      end
      new_state.turns_without_points = 0
    else
      new_state.turns_without_points += 1
    end
    
    if(state.turn == 1)
      new_state.turn = 2
    else
      new_state.turn = 1
    end
    new_state
  end

  def is_eating(piece_x, piece_y, dest_x, dest_y,table)
    piece = table[piece_x][piece_y]
    delta_x = dest_x - piece_x
    delta_y = dest_y - piece_y
    if(piece_team(piece) == 1)
      if(!king(piece))
        if(delta_x != -2 || delta_y.abs() != 2 )
          return false
        end
        if(piece_team(table[piece_x - 1][piece_y + delta_y/2]) != 2)
          return false
        end
        return true
      else
        if(delta_x.abs() != 2 || delta_y.abs() != 2)
          return false
        end
        if(piece_team(table[piece_x + delta_x/2][piece_y + delta_y/2]) != 2)
          return false
        end
        return true
      end
    else
      if(!king(piece))
        if(delta_x != +2 || delta_y.abs() != 2 )
          return false
        end
        if(piece_team(table[piece_x + 1][piece_y + delta_y/2]) != 1)
          return false
        end
        return true
      else
        if(delta_x.abs() != 2 || delta_y.abs() != 2)
          return false
        end
        if(piece_team(table[piece_x + delta_x/2][piece_y + delta_y/2]) != 1)
          return false
        end
        return true
      end
    end
  end
  
  def validate_action(state, action)
    return 'Coodenadas inválidas' if invalid_coord(action)

    piece_x = action[0]
    piece_y = action[1]
    piece = state.table[piece_x][piece_y]

    dest_x = action[2]
    dest_y = action[3]
    dest = state.table[dest_x][dest_y]

    return 'Escolha uma peça válida' if(piece_team(piece) != state.turn)
    
    return 'Mova para uma posição válida' if(dest != 0)

    if (has_to_eat(state))
      if (!can_eat(piece_x, piece_y, state.table))
        return 'Você deve comer a peça inimiga'
      else
        if(!is_eating(piece_x,piece_y, dest_x, dest_y,state.table))
          return 'Você deve comer a peça inimiga'
        else
          return
        end
      end
    end

    if(invalid_destination(piece_x, piece_y, dest_x, dest_y, piece))
      return 'Mova para uma posição válida'
    end
  end

  def has_ended(state)
    return state.pieces_player1 == 0 || state.pieces_player2 == 0 || (state.turns_without_points == 40 && state.turns_without_promotion == 40)
  end
  
end
