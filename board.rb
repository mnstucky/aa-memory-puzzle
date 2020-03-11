class Board

    attr_reader :size

    def initialize(size)
        @board = Array.new(size) {Array.new(size)}
        @open_positions = []
        @size = size
        alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        @letters = alphabet.split("")
    end
    
    def number_of_matches
        (self.size * self.size) / 2
    end
    
    def populate_open_positions
        (0...size).each do |idx1| 
            (0...size).each { |idx2| @open_positions << [idx1, idx2] }
        end
    end
    
    def populate_board
        
        self.populate_open_positions

        while @open_positions.length > 0

            selected_positions = @open_positions.sample(2)
            selected_letter = @letters.sample

            selected_positions.each do |position|
                @board[position[0]][position[1]] = Card.new(selected_letter)
                @open_positions.delete(position)
            end

            @letters.delete(selected_letter)

        end

    end

    def render
        system('clear')

        print "  "
        (0..size-1).each do |num|
            print "#{num} "
        end
        puts
        @board.each.with_index do |subarr, idx|
            print idx
            subarr.each do |card|
                print " "
                card.print_card
            end
            puts
        end
    end

    def won?
        @board.all? do |subarr|
            subarr.all? { |card| card.face_up == true }
        end
    end

    def switch(guessed_pos)
        x, y = guessed_pos
        @board[x][y].switch
    end

    def value_at(guessed_pos)
        x, y = guessed_pos
        @board[x][y].face_value
    end

    def valid_guess?(guessed_pos)
        x, y = guessed_pos
        return false if x >= size || x < 0
        return false if y >= size || y < 0
        return false if @board[x][y].face_up == true
    end

end