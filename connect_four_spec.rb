require_relative "connect_four"

describe Cage do

	let(:game) { Cage.new }

	let(:player) { double(:color => "r", :picked => [0,0]) }

	puts "ran"

	it "initializes as Cage class" do
		expect(Cage.new).to be_instance_of(Cage)
	end

	describe "#free_spaces?" do

		it "returns false when column full" do
			game.cage.each { |row| row.each { |cir| cir << "b" } }

			expect(game.free_spaces?(3)).to eql(false)
		end
	end

	describe "#make_move" do

		it "takes a value if inputed" do
			game.make_move(1, player)

			expect(game.cage[5][1]).to eql("r")
		end

		it "increases number of moves taken" do
			game.instance_variable_set("@moves", 0)
			game.make_move(5, player)

			expect(game.moves).to eql(1)
		end
	end

	describe "#winner" do

		it "returns true if player has four horizontal discs in a row" do
			game.cage[0] = ["r","r","r","r"," "," "," "]
			game.check_winner

			expect(game.winner).to eql(true)
		end

		it "returns false if four horizontal discs are not in a row" do
			game.cage[0] = ["r","r"," ","r","r"," "," "]
			game.check_winner

			expect(game.winner).to eql(false)
		end

		it "returns true if player has four vertical discs in a row" do
			
			i = 0
			4.times do
				game.cage[i][0] = "r"
				i += 1
			end

			game.check_winner

			expect(game.winner).to eql(true)
		end

		it "returns false if player has four vertical discs not in a row" do

			i = 0
			2.times do
				game.cage[i][0] = "r"
				i += 1
			end
			
			i = 3
			2.times do
				game.cage[i][0] = "r"
				i += 1
			end

			game.check_winner

			expect(game.winner).to eql(false)
		end

		it "returns true if player has four in a diagonal row" do

			i = 0
			4.times do
				game.cage[i][i] = "r"
				i += 1
			end

			game.check_winner

			expect(game.winner).to eql(true)
		end

		it "declares a draw if total moves up" do
			game.instance_variable_set("@moves", 42)
			
			expect(game.check_draw).to eql(true)
		end

		it "doesn't declares a draw if total moves not up" do
			game.instance_variable_set("@moves", 41)
			
			expect(game.check_draw).not_to eql(true)
		end
	end

end