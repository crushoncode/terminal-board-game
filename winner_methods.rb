require 'catpix'
require 'colorize'

def check_if_winner(position, name, emoji)
  if position >= 69
    winner_screen(name, emoji)
  else
    return nil
  end
end

def winner_screen(name, emoji)
  puts "#{emoji}#{name.upcase} IS THE WINNER! CONGRATULATIONS".to_s.colorize(:color => :white, :background => :blue).rjust(87)

  Catpix::print_image "winner_dice.jpeg",
  :limit_x => 0.75,
  :limit_y => 0,
  :center_x => true,
  :center_y => false,
  :bg => "white",
  :bg_fill => false
  exit
end