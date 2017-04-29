class Cage

	def initialize
		@cage = Array.new(6).map { Array.new(7) }
		@cage.each { |rows| rows.map! { |circles| circles = " " } }
		@moves = 0
	end
	
	def player_turn
	  @player_turn
	end
	
	def print_cage
    i = -1
    row1 = @cage[0][0..7]
    row2 = @cage[1][0..7]
    row3 = @cage[2][0..7]
    row4 = @cage[3][0..7]
    row5 = @cage[4][0..7]
    row6 = @cage[5][0..7]
    puts "\n" + row1.join("  |  ") + "\n"
    37.times { print "-" }
    puts "\n" + row2.join("  |  ") + "\n"
    37.times { print "-" }
    puts "\n" + row3.join("  |  ") + "\n"
    37.times { print "-" }
    puts "\n" + row4.join("  |  ") + "\n"
    37.times { print "-" }
    puts "\n" + row5.join("  |  ") + "\n"
    37.times { print "-" }
    puts "\n" + row6.join("  |  ") + "\n"
    37.times { print "-" }
  end

  def moves
  	@moves
  end

	def cage
		@cage
	end

	def check(position, player)
		player.picked.include?(position)
	end
	
	def prompt_player(player)
	  @player_turn = player.color
	  if player.color == "r"
	    puts "Player red make move"
	 else
	  	puts "Player black make move"
	 end
	  input = gets.chomp.split(',').map { |e| e.to_i }
    make_move(input, player)
	end

	def make_move(input, player)
		row = input[0]
		column = input[1]
		if row > 5 || column > 6
			"Select a value up to 5 for row and 6 for column"
		else
			@moves += 1
			@cage[row][column] = player.color
		end
	end

	def check_rows
		i = 0
		discs = []
		@cage.each do |row|
			row.each do |circle|
				discs << circle
				if circle == discs[-2] && circle != " "
					i += 1
					if i == 3
					  if circle == discs[-1]
					  	i +=1 
					  else
					  	i = 0
					  end
					end
				else
					i = 0
				end
				if i >= 4
					return true
				end
			end
		end
		false
	end

	def check_for_vertical_duplicates(c_indices, r_indices)
		duplicates = c_indices.select { |e| c_indices.count(e) >= 4 }
		duplicates != [] && r_indices.sort.each_cons(2).all? { |x,y| y == x + 1 } == true ? true : false
	end

	def check_columns
		c_indices = []
		r_indices = []
		@cage.each_with_index do |row, r_index|
			row.each_with_index do |circle, c_index|
				if circle != " "
					c_indices << c_index
					r_indices << r_index
				end
			end
		end
		check_for_vertical_duplicates(c_indices, r_indices)
	end

	def check_for_draw
		if @moves >= 42
		  print_cage
		  puts "It's a draw!"
		  true
		else
		  false
		end
	end

	def diagonal_matches(positions)
		if positions.length >= 4
		  a = positions.map! { |elem| elem.join(', ').to_i }
		  if a[a.size-1] == a[0] + a.size-1
		    return true
		  end
		end
	end
	
	def check_for_diagonal
		positions = []
		@cage.each_with_index do |row, r_index|
			row.each_with_index do |circle, c_index|
				if circle != " "
					positions << [r_index, c_index]
				end
			end
		end
		if positions != []
			diagonal_matches(positions)
		end
	end

	def winner
		if check_rows == true
		  if @player_turn == "r"
		    print_cage
		    puts "Player red wins!"
		    return true
		  else
		  	print_cage
		    puts "Player black wins!"
		    return true
			end
		elsif check_columns == true
		  if @player_turn == "r"
		    print_cage
  		  puts "Player red wins!"
  		  return true
  		else
  		  print_cage
  		  puts "Player black wins!"
  		  return true
			end
		elsif check_for_diagonal == true
			if @player_turn == "r"
			  print_cage
  		  puts "Player red wins!"
  		  return true
  		else
  		  print_cage
  		  puts "Player black wins!"
  		  return true
			end
		else 
			check_for_draw
		end
	end

end

class Player

	def initialize(color)
		@color = color
	end

	def color
		@color
	end
end

my_game = Cage.new
player1 = Player.new("b")
player2 = Player.new("r")

=begin while my_game.winner == false
  puts "\n"
  my_game.print_cage
  print "\n"
  my_game.prompt_player(player1)
  if my_game.winner == true
    break
  end
  puts "\n"
  my_game.print_cage
  print "\n"
  my_game.prompt_player(player2)
  my_game.winner
end
=end