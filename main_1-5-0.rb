require_relative 'winner_methods.rb'
require_relative 'board_methods.rb'
require_relative 'questions.rb'

require 'colorize'
require 'terminal-table'
require 'pry'
require 'catpix'

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

welcome_screen
system 'clear'

print "Enter Player 1's name: "
p1_name = gets.strip.capitalize
print "Enter Player 2's name: "
p2_name = gets.strip.capitalize

emoji_menu = ["🐶", "🐹", "🐯", "🐷", "🙉", "🐬"]

def print_emojis(emoji_menu)
    emoji_menu.each_with_index do |value, index|
        puts "\t#{index + 1}: #{value}"
    end
end

def select_emojis(emoji_menu, player_number, name)
    puts "Emoji Menu"
    print_emojis(emoji_menu)
    print "#{name} please pick your emoji: "
    user_selection = gets.chomp.to_i - 1
    until user_selection.between?(0, 5)
        puts "Please type a number between 1 and 6"
        user_selection = gets.chomp.to_i - 1
    end
    player_emoji = emoji_menu[user_selection]
    puts "Selection: #{player_emoji}"
    sleep 0.5
    system 'clear'
    return player_emoji
end

p1_emoji = select_emojis(emoji_menu, 1, p1_name)
p2_emoji = select_emojis(emoji_menu, 2, p2_name)

players = [
    {
    name: "#{p1_name}",
    position: 10,
    emoji: "#{p1_emoji}"
    }, 
    {
    name: "#{p2_name}",
    emoji: "#{p2_emoji}", 
    position: 10
    }
]

puts "#{players[0][:name]}#{players[0][:emoji]} VS #{players[1][:name]}#{players[1][:emoji]}"

squares = [
  ["🌳🌳🌳🌳","🌳🌳🌳🌳","🌳🌳🌳🌳","🌳🌳🌳🌳","🌳🌳🌳🌳","🌳🌳🌳🌳","🌳🌳🌳🌳","🌳🌳🌳🌳","🌳🌳🌳🌳","🌳🌳🌳🌳"],
  ["#{players[0][:emoji]}#{players[1][:emoji]}    \n \n \n","  01  ","  02  ","  03  ","  04 ❓","  05  ","  06  ","  07  ","  08  ","  09  "],
  ["  10  \n \n \n","  11 ❓","  12  ","  13  ","  14  ","  15  ","  16  ","  17  ","  18  ","  19  "],
  ["  20  \n \n \n","  21  ","  22  ","  23 ❓","  24  ","  25  ","  26  ","  27  ","  28  ","  29  "],
  ["  30  \n \n \n","  31 ❓","  32  ","  33  ","  34  ","  35  ","  36  ","  37  ","  38  ","  39  "],
  ["  40  \n \n \n","  41 ❓","  42  ","  43  ","  44  ","  45  ","  46  ","  47  ","  48 ❓","  49  "],
  ["  50  \n \n \n","  51  ","  52  ","  53  ","  54  ","  55 ❓","  56  ","  57  ","  58  ","  🏁🏁  "]
]

questions = [
    {question: "What is Ruegen's last name?", answer: "aschenbrenner"},
    {question: "What is the output of: [1,2,3].shift", answer: "1"},
    {question: "What terminal command is used to rename a file?", answer: "mv"},
    {question: "What is the output of: 2 ** 3", answer: "8"},
    {question: "What is the output of: 10 % 3", answer: "1"},
    {question: "True or False?: (Sarinas age + Marks age + Jakes age) < 80", answer: "false"},
    {question: "Ruegen always says coders are...", answer: "lazy"},
    {question: "What should the extension for our README files be?", answer: "md"},
    {question: "What terminal command creates a folder?", answer: "mkdir"},
    {question: "!!!!!!!!true is", answer: "true"},
    {question: "!!!!!!!!!!!!!!!!!false is", answer: "true"},
    {question: "Method to removes whitespace from end of a string is", answer: "chomp"}
]

display_board(squares, players)

winner = false
until winner
    players.each_with_index do |player, index|
        print "Start of #{player[:emoji]}#{player[:name]}'s turn. Press return to roll dice"
        gets
        system 'clear'
        roll_result = animated_dice_roll
        animate_movement(player, index, squares, roll_result, players)
        puts "#{player[:emoji]}#{player[:name]} moved to square #{player[:position]-10}"
        if is_question_square(player[:position])
          bonus_squares = question_square(questions)
          animate_movement(player, index, squares, bonus_squares, players)
        end   
        puts "End of #{player[:emoji]}#{player[:name]}'s turn"
    end
end