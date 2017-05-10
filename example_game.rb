require_relative "connect_four"

my_game = Cage.new
player1 = Player.new("b")
player2 = Player.new("r")

while my_game.winner == false
  puts "\n"
  my_game.print_cage
  print "\n"
  my_game.prompt_player(player1)
  my_game.check_winner 
  break if my_game.winner == true
    
  puts "\n"
  my_game.print_cage
  print "\n"
  my_game.prompt_player(player2)
  my_game.check_winner
end

my_game.declare_winner if my_game.winner == true