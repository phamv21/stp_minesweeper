require_relative 'board'
require 'yaml'
class Game 
    attr_reader :board, :saved_board
    def initialize
        @board = Board.new
        @saved_board = ""
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
        elsif decision == "f"
            board.flag(pos)
        else
            @saved_board = board.to_yaml
        end
    end
    

    def run
        if saved_board == ""
        set_up_board
        end
        until board.game_over?
            play_turn
        end
        
        if board.finish
            puts "You have step on mine, try again"
            try_from_saved_point?
        else
            board.render
            puts "Unbelievable! You are genius"
        end
    end

    def load_saved_game
        @board = YAML::unsafe_load(saved_board)
    end

    def try_from_saved_point?
        respond = ""
        while true
            puts "do you want to load the saved game? yes or no"
            print "> "
            respond = gets.chomp
            case respond
            when "yes"
                load_saved_game
                system("clear")
                run
                break
            when "no"
                board.render
                puts "too hard, I know"
                break
            else
                puts "only yes or no please"
            end

        end
        
    end

    def get_decision
        decision = ""
        while true
            puts "put f for flag, r for reveal s for save the current game."
            print "> :"
            decision = gets.chomp
            case decision
            when "f" 
                break
            when "r"
                break
            when "s"
                break
            else 
                puts "you can only put: f or r or s"
            end
        end
        decision
    end

    def parse_pos(string)
        string.split(",").map{|char| Integer(char)}
    end
    def parse_val(string)
        Integer(string)
    end

    def valid_pos?(pos)
        pos.is_a?(Array)&& pos.length == 2 &&
        pos.all?{|x| x.between?(0,8)}
    
    end

    def valid_val?(val)
        val.is_a?(Integer)&&
        val.between?(1,80)
    end




end

game = Game.new
game.run