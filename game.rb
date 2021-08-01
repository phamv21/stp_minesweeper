require_relative "board"
class Game
    attr_reader :board
    def initialize
        @board = Board.new
    end

    def get_pos
        pos = nil
        until pos && valid_pos?(pos)
            
            begin
                puts "Please enter a position on the board (e.g., '3,4')"
                print "> "
                pos = parse_pos(gets.chomp)
                rescue
                puts "you have entered wrong format of postition. Did you seperate them by , ?"
                puts ""
                pos = nil
            end
        end
        pos
    end

    def get_val
        val = nil
        until val && valid_val?(val)
            puts "please enter number of mines (a positive number less than 81)"
            print "> :"
            val = parse_val(gets.chomp) 
        end
       val 
    end

    def get_decision
        decision = ""
        while true
            puts "put f for flag, r for reveal"
            print "> :"
            decision = gets.chomp
            case decision
            when "f" 
                break
            when "r"
                break
            else
                puts "you can only put: f or r"
            end
        end
        decision
    end

    def set_up_board
        val = get_val
        board.setup_mines(val)
        board.scan_fringles
    end

    def play_turn
        board.render
        pos = get_pos
        decision = get_decision
        if decision == "r"
            board.reveal(pos)
        else
            board.flag(pos)
        end
    end

    def run
        set_up_board
        until board.game_over?
            play_turn
        end
        board.render
        if board.finish
            puts "You have step on mine, try again"
        else
            puts "You are genius"
        end
    end


    def parse_pos(string)
        string.split(",").map{|char| Integer(char)}
    end
    def parse_val(string)
        Integer(string)
    end

    def valid_pos?(pos)
        x,y = pos
        x.between?(0,8)&&y.between?(0,8)
    end

    def valid_val?(val)
        val.is_a?(Integer)&&
        val.between?(1,80)
    end




end

game = Game.new
game.run