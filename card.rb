class Card

    attr_reader :face_up, :face_value

    def initialize(value)
        @face_value = value
        @face_up = false
    end

    def switch
        if @face_up == false
            @face_up = true
        else
            @face_up = false
        end
    end

    def print_card
        print "#{@face_value}" if @face_up
        print " " unless @face_up
    end

end 