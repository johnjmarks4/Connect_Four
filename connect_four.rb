class Cage
	attr_accessor :cage

	def initialize
		@cage = Array.new(6).map { Array.new(7) }
		@cage.each { |rows| rows.map! { |circles| circles = " " } }
		@moves = 0
		@winner = false
	end
	
	def print_cage
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

  def cage #included for testing purposes
  	@cage
  end

  def moves
  	@moves
  end
	
	def prompt_player(player)
	  @player_turn = player.color
	  if player.color == "r"
	    puts "Player red move"
	  else
	  	puts "Player black move"
	  end
	  input = gets.chomp.to_i
    make_move(input, player)
	end

	def make_move(column, player)
	  row = find_free(column)
		if column > 6
			puts "Select a value between 0 and 6"
			prompt_player(player)
		elsif free_spaces?(column) != true
		  puts "That column is already full"
		  prompt_player(player)
		else
			@moves += 1
			@cage[row][column] = player.color
		end
	end
	
	def find_free(column)
	  row = @cage.find_index { |row| row[column] != " " }
	  row != nil ? row - 1 : 5
	end
	
	def free_spaces?(column)
	  @cage.any? { |row| row[column] == " " }
	end
	
	def winner
	  @winner
	end
	
	def check_winner
	  check_draw
		@cage.each_with_index do |row, r_index|
		  row.each_with_index do |cir, c_index|
		    if cir == "b" || cir == "r"
		      
		      #check horizontal win
		      if c_index <= 3 && (cir == @cage[r_index][c_index + 1] && cir == @cage[r_index][c_index + 2] && cir == @cage[r_index][c_index + 3])
		        @winner = true
		      
		      #check vertical win
		      elsif r_index <= 2 && (cir == @cage[r_index + 1][c_index] && cir == @cage[r_index + 2][c_index] && cir == @cage[r_index + 3][c_index])
		        @winner = true
		      
		      #check diagonal win
		      elsif r_index <= 2 && c_index <= 3 && (cir == @cage[r_index + 1][c_index + 1] && cir == @cage[r_index + 2][c_index + 2] && cir == @cage[r_index + 3][c_index + 3])
            @winner = true
          elsif r_index <= 2 && c_index >= 3 && (cir == @cage[r_index + 1][c_index - 1] && cir == @cage[r_index + 2][c_index - 2] && cir == @cage[r_index + 3][c_index - 3])
            @winner = true
		      end
		    end
		  end
	  end
	end

	def check_draw
		if @moves >= 42
		  print_cage
		  puts "\n"
		  puts "It's a draw!"
		  @winner = true
		end
	end
	
	def declare_winner
	  print_cage
	  puts "\n"
	  puts "Player black wins" if @player_turn == "b"
	  puts "Player red wins" if @player_turn == "r"
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