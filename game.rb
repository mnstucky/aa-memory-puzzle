require_relative './board.rb'
require_relative './card.rb'
require_relative './player.rb'
require_relative './ai.rb'

class Game
    
    def initialize(size=4)
        @gameboard = Board.new(size)
        @gameboard.populate_board
        @player
    end
    
    def play

        self.start_game
        
        while !@gameboard.won?

            @gameboard.render
            guess1 = @player.get_guess
            @gameboard.switch(guess1)
            sleep(1)
            @gameboard.render
            guess2 = @player.get_guess
            @gameboard.switch(guess2)
            sleep(1)
            @gameboard.render
            sleep(1)
            if @gameboard.value_at(guess1) != @gameboard.value_at(guess2)
                @gameboard.switch(guess1)
                @gameboard.switch(guess2)
            else
                @player.delete_match(guess1, guess2)
            end
            system('clear')
        end

        puts "You won!"

    end

    def start_game

        print "Who's playing? Enter \"me\" or \"AI\": "
        input = gets.chomp
        if input == "me"
            print "Enter your name: "
            name = gets.chomp
            @player = Player.new(name, @gameboard)
        elsif input == "AI"
            @player = Ai.new("Linus", @gameboard)
        else
            print "Wrong entry."
        end

    end
end

# code for quick testing

g = Game.new(2)
g.play