
def question_square(questions)
  puts "You landed on a question square!" 
  sleep 0.25 
  answer = ask_question(questions)
  system 'clear' 
  if answer == true 
    puts "👍CORRECT! Roll again! (press return)"
    gets
    system 'clear'
    return animated_dice_roll
  else 
    puts "👎INCORRECT!" 
    sleep 1
    return 0 
  end 
end 
  
def is_question_square(square) 
  if square == 14 || square == 21 || square == 33 || square == 41 || square == 51 || square == 58 || square == 65
    return true 
  else 
    return false 
  end    
end 
  
def ask_question(questions)
  question_answer = questions.sample
  puts question_answer[:question]
  answer = gets.chomp.downcase
  if answer == question_answer[:answer]
    puts "Correct"
    questions.delete(question_answer)
    return true
  else
    puts "Incorrect"
    return false
  end
  puts questions
end