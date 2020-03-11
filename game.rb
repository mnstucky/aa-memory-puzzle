require_relative './board.rb'
require_relative './card.rb'

class Game
    
    def initialize(size=4)
        @gameboard = Board.new(size)
        @gameboard.populate_board
    end
    
    def play

        while !@gameboard.won?

            system('clear')
            @gameboard.render
            print "Guess a position (format: numbernumber): "
            guess1 = self.get_guess
            @gameboard.switch(guess1)

            system('clear')
            @gameboard.render
            print "Guess another position: "
            guess2 = self.get_guess
            @gameboard.switch(guess2)

            system('clear')
            @gameboard.render
            sleep(1)
            if @gameboard.value_at(guess1) != @gameboard.value_at(guess2)
                @gameboard.switch(guess1)
                @gameboard.switch(guess2)
            end
            system('clear')
        end

        puts "You won!"

    end

    def get_guess
        
        input = gets.chomp
        while valid_input?(input) == false
            print "Invalid guess. Try again: "
            input = gets.chomp
        end
        guess = guess_to_array(input)
        while @gameboard.valid_guess?(guess) == false
            print "Invalid guess. Try again: "
            input = gets.chomp
            guess = guess_to_array(input)
        end

        return guess
    end

    def guess_to_array(input)
        guess = input.split("")
        guess.map!(&:to_i)
        return guess
    end

    def valid_input?(input)
        digits = "0123456789"
        return false if !digits.include?(input[0])
        return false if !digits.include?(input[1])
        return false if input.length > 2
        true
    end

end