# Terminal Board Game

Navigation:
- [Description](#description)
- [Idea](#idea)
- [Planning](#planning)
- [Design Approach](#design-approach)
  - [Methods](#methods)
  - [Gems](#gems)
    - [terminal-table](#terminal-table)
    - [catpix](#catpix)
    - [colorize](#colorize)
    - [pry](#pry)
- [Changelog](#changelog)
  - [Ver 0.0.3](#ver-003)
  - [Ver 0.1.0](#ver-010)
  - [Ver 1.0.0](#ver-100)
  - [Ver 1.5.0](#ver-150)
- [Authors](#authors)

## Description
A simple board game displayed and played from the terminal, written in Ruby.

---
## Idea

We decided to use the terminal-table gem as a board-game table, that could track and display player movement, and move to a winner screen upon reaching or surpassing the last square.

---
## Planning

As our minimum viable product, we wanted to include the following functionality:
- Display a board
- Display player positions on the board
- Increment player positions with a dice roll, emulated with the .rand method
- Update board upon each movement
- Determine and display the winner

We also brainstormed a number of other functions, and among them, managed to include the following:
- User-defined player names, and user-selected emojis to represent board position
- Allocated 'question squares', with methods to ask a random question, and move the player forward if answered correctly
- Animated dice roll
- Animated player movement
- Pictures that display on welcome and winner screens

---
## Design Approach

We started by designing the board.

We anticipated a number of problems prior to development, and structured our design approach to [overcome] these potential issues.

- For example, one of our most prominent concerns was representing the players' position on the board. We knew that the terminal table would have to be constructed by pushing in arrays of values (squares), but we had to think about how we would reference those specific squares in order to change how they would be displayed. We decided to make each row as an array of 10 strings that could be modified as needed. Because these arrays had 10 values each, we could reference them easily by selecting the row number as the selector for the squares array, and the column number as the selector within the row. For example, squares[0][1] would return square 01, and squares[1][6] would return square 16.

### Methods
Flow of code contains methods doing the following:
- Display welcome screen
- Players enter names
- Players select Emoji
- Display the board
- Roll and animate dice
- Clear player's previous postion
- Display and animate player movement until reached new position
- Check if square contains a question
  - If true ask a question
    - If correct roll again
    - If wrong end of turn
- Check if player has won
  - If true display winner screen and end game
  - If false next players turn

### Gems
In achieving the end result we utilized the following gems:
#### terminal-table
  - Used to display our board
#### catpix
  - To display images for the welcome and winner screens
#### colorize
  - To highlight text and text background
#### pry
  - To debug errors

---
## Changelog

### Ver 0.0.3

- made an array of hashes for players to track position

```ruby
players = [
    {emoji: "🐹",
    position: 10}, 
    {emoji: "🐷", 
    position: 10},
    {emoji: "🐯",
    position: 10}
]
```

- board has three rows
    - trees added to bypass number-of-digit problem
```ruby
squares = [
            ["🌳","🌳","🌳","🌳","🌳","🌳","🌳","🌳","🌳","🌳"],
            ["10","11","12","13","14","15","16","17","18","19"],
            ["20","21","22","23","24","25","26","27","28","29"]
        ]
```

- managed to get rows into a table
```ruby
rows = []
rows << squares[0]
rows << squares[1]
rows << squares[2].reverse
table = Terminal::Table.new :rows => rows

puts table
```

- remove player from previous square
```ruby
roll_result = rand(1..6)
        puts "#{player[:emoji]} rolled: #{roll_result}"

        row = player[:position].to_s[0].to_i
        col = player[:position].to_s[1].to_i
        squares[row][col] = "#{row}#{col}"
```

- increment player position and add emoji to new position
```ruby
player[:position] += roll_result
        row = player[:position].to_s[0].to_i
        col = player[:position].to_s[1].to_i
        puts "now on square #{player[:position]}"
        squares[row][col] = player[:emoji]
```


### Ver 0.1.0

- Fixed overlapping by creating empty spaces on each square
```ruby
squares = [
  ["🌳🌳🌳🌳","🌳🌳🌳🌳","🌳🌳🌳🌳","🌳🌳🌳🌳","🌳🌳🌳🌳","🌳🌳🌳🌳","🌳🌳🌳🌳","🌳🌳🌳🌳","🌳🌳🌳🌳","🌳🌳🌳🌳"],
  ["#{players[0][:emoji]}#{players[1][:emoji]}    ","    01","    02","  03  ","  04  ","  05  ","  06  ","  07  ","  08  ","  09  "],
  ["  10  ","  11  ","  12  ","  13  ","  14  ","  15  ","  16  ","  17  ","  18  ","  🏁   "]
]
```
- And assigning each player to a certain empty space
```ruby
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
  ```

- winner screen and check_if_winner method added
```ruby
def check_if_winner(position, emoji)
  if position >= 29
    winner_screen(emoji)
  else
    return nil
  end
end

# winner screen here
def winner_screen(emoji)
  puts "WINNER!!! #{emoji} WINNER!!!!"
  exit
end
```

### Ver 1.0.0

-  moved methods to the separate document
-  animated dice roll 
```ruby
def animated_dice_roll
  36.times do
    print "\r 🎲 Rolling dice....#{roll_dice}"
    sleep 0.05
  end
  final_roll = roll_dice
  print "\r 🎲 Rolling dice....#{final_roll}"
  sleep 1
  return final_roll
end
```
- animated movement 
```ruby
def animate_movement(player, index, squares, roll_result, players) 
 roll_result.times do 
    system 'clear' 
    rm_previous_position(player, index, squares) 
    player[:position] += 1 
    add_emoji_to_position(player, index, squares) 
    display_board(squares, players) 
    check_if_winner(player[:position], player[:emoji]) 
    sleep 0.25 
  end 
end
```
- added questions to certain squares, and a method to check for correct answer
- only one question at this point
```ruby
def question_square 
 puts "You landed on a question square!" 
 sleep 0.25 
 print "1 + 1 = " 
 answer = gets.strip.to_i 
 system 'clear' 
 if answer == 2 
   puts "CORRECT! Move 2 more spaces! (press return)"
   gets
   return 2  
 else 
   puts "WRONG! No more squares for you! (press return)" 
   gets
   return 0 
 end 
end 

def is_question_square(square) 
 if square == 13 || square == 14 || square == 15 || square == 16 #question squares 
   return true 
 else 
   return false 
 end    
end 
```

### Ver 1.5.0
- added a list of questions and answers in an array of hashes
```ruby
questions = [
  {question: "What is Ruegen's last name?", answer: "aschenbrenner"},
  {question: "What is the output of: [1,2,3].shift", answer: "1"},
  {question: "What terminal command is used to rename a file?", answer: "mv"},
  {question: "What is the output of: 2 ** 3", answer: "8"},
  {question: "What is the output of: 10 % 3", answer: "1"},
  {question: "True or False?: (sarinas_age + marks_age + jakes_age) < 80", answer: "false"},
  {question: "Ruegen says coders are...", answer: "lazy"},
  {question: "What should the extension for our README files be?", answer: "md"},
  {question: "What terminal command creates a folder?", answer: "mkdir"}
]
```

```ruby
def question_square 
 puts "You landed on a question square!" 
 sleep 0.25 
 print "1 + 1 = " 
 answer = gets.strip.to_i 
 system 'clear' 
 if answer == 2 
   puts "CORRECT! Move 2 more spaces! (press return)"
   gets
   return 2  
 else 
   puts "WRONG! No more squares for you! (press return)" 
   gets
   return 0 
 end 
end 

def is_question_square(square) 
 if square == 13 || square == 14 || square == 15 || square == 16 #question squares 
   return true 
 else 
   return false 
 end    
end 
```

- added welcome screen
```ruby
def welcome_screen
    system 'clear'
    puts "Welcome to terminal board game. The rules are simple, there are two players, whoever gets to the end first wins!"
    puts "If you land on a square with a ❓, get a question right to roll again!\n\n\n\n\n"
    
    Catpix::print_image "start.jpeg",
    :limit_x => 0.5,
    :limit_y => 0,
    :center_x => true,
    :center_y => false,
    :bg => "white",
    :bg_fill => false

    puts "Ready? (press return)"
    gets
end
```
Added picture to winner screen using catpix gem
```ruby
def winner_screen(name, emoji)
  puts "#{emoji}#{name.upcase} IS THE WINNER! CONGRATULATIONS".to_s.colorize(:color => :white, :background => :blue).rjust(87)

  Catpix::print_image "winner_dice.jpeg",
  :limit_x => 0.75, #should be 1
  :limit_y => 0,
  :center_x => true,
  :center_y => false,
  :bg => "white",
  :bg_fill => false
  exit
end
```


---
## Authors
Mark Tice, Jake Pitman, Serina Ko