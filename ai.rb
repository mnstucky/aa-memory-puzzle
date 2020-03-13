require_relative './board.rb'
require 'byebug'

class Ai

    def initialize(name, board)
        @name = name
        @gameboard = board
        @new_guesses = []
        self.populate_guesses
        @known_cards = Hash.new { |h, k| h[k] = [] }
        @guess_num = 0
        @match
        @match_exists
        @just_found_match
    end
        
    def populate_guesses
        (0...@gameboard.size).each do |idx1| 
            (0...@gameboard.size).each { |idx2| @new_guesses << [idx1, idx2] }
        end
    end

    def get_guess

        debuggerAI
        @match_exists = false
        @known_cards.each { |k, v| @match_exists = true if v.length > 1 }
        
        if @guess_num == 0

            if @match_exists
                @known_cards.each { |k, v| @match = v if v.length > 1 }
                self.process_guess(@match[0])
                @just_found_match = false
                return @match[0] 
            else 
                guess = @new_guesses.sample
                @known_cards[@gameboard.value_at(guess)] << guess
                self.process_guess(guess)
                @just_found_match = true
                return guess
            end

        else

            if @match_exists
                # debugger
                @known_cards.each do |k, v| 
                    if v.length > 1 
                        @match = v 
                    end
                end
                self.process_guess(@match[1])

                if @just_found_match == false
                    return @match[1] 
                else
                    return @match[0]
                end
               
            else
                guess = @new_guesses.sample
                @known_cards[@gameboard.value_at(guess)] << guess
                self.process_guess(guess)
                return guess   
            end          
        
        end

    end

    def delete_match(guess1, guess2)
        @known_cards.delete(@known_cards.key([guess1, guess2]))
    end

    def process_guess(guess)
        @new_guesses.delete(guess)
        self.switch_guess_num
    end
    
    def switch_guess_num

        if @guess_num == 0
            @guess_num = 1 
        else
            @guess_num = 0
        end

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