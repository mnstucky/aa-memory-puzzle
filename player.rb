require_relative './board.rb'
require 'byebug'

class Player

    def initialize(name, board)
        @name = name
        @gameboard = board
    end

    def prompt
        print "#{@name} - Guess a position (e.g., 01): "
    end
    
    def get_guess
        
        self.prompt
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
        return false if input.length < 2
        return false if !digits.include?(input[0])
        return false if !digits.include?(input[1])
        return false if input.length > 2
        true
    end

end