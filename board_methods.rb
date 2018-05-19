def display_board(squares, players)
  table = Terminal::Table.new do |t|
    squares.each_with_index do |row, i|
      if i.even?
        t << row.reverse
      else
        t << row
      end
        t << :separator
    end
  end
  puts table
end

def animated_dice_roll
  24.times do
    print "\r 🎲 Rolling dice....#{roll_dice}"
    sleep 0.05
  end
  final_roll = roll_dice
  print "\r 🎲 Rolling dice....#{final_roll}"
  sleep 1
  return final_roll
end

def roll_dice()
 rand(1..6)
end

def rm_previous_position(player, index, squares)
 row = player[:position].to_s[0].to_i
 col = player[:position].to_s[1].to_i
 squares[row][col][index] = " "
end

def add_emoji_to_position(player, index, squares)
 row = player[:position].to_s[0].to_i
 col = player[:position].to_s[1].to_i
 squares[row][col][index] = "#{player[:emoji]}"
end

def animate_movement(player, index, squares, roll_result, players) 
 roll_result.times do 
    system 'clear' 
    rm_previous_position(player, index, squares) 
    player[:position] += 1 
    add_emoji_to_position(player, index, squares) 
    display_board(squares, players) 
    check_if_winner(player[:position], player[:name], player[:emoji]) 
    sleep 0.15 
  end 
end