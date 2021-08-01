require_relative "tile"
class Board
    attr_reader :grid
    def initialize
        @grid = Array.new(9) do
            Array.new(9){Tile.new(false)}
        end
    end

    def []=(pos,value)
        x,y = pos
        grid[x][y] = value
    end
    def [](pos)
        x,y = pos
        grid[x][y]
    end

    def setup_mine(number)
        count = number
            until count == 0
                x = rand(0..8)
                y = rand(0..8)
                if self[[x,y]].mine == false
                self[[x,y]] = Tile.new(true)
                count -= 1 
                end
            end
    end
    

    
    def set_flag(pos)
        self[pos].change_flag
    end

    def reveal(pos)
        self[pos].reveal
        auto_reveal
    end

    def render
        rows.each do |row|
            puts row.join(" ")
        end
    end

    

    


    def win?
        
    end

    def lose?
        
    end
    def valid_pos(pos)
        x,y = pos
        x.between?(0,8)&&y.between?(0,8) 
    end

    def set_fringle(pos)
        count = 0
        if self[pos].mine == false
                x,y = pos

                (x-1..x+1).each do |i|
                    (y-1..y+1).each do |j|
                        if valid_pos([i,j])
                            count += 1 if self[[i,j]].mine 
                        end
                    end
                end
        self[pos].fringle = count
            else
        self[pos].fringle = 9
        end
    end
    def scan_fringle
        (0..8).each do |x|
            (0..8).each do |y|
            set_fringle([x,y])
            end
        end
    end
    def auto_reveal
        (0..8).each do |x|
            (0..8).each do |y|
                if self[[x,y]].fringle == 0 && self[[x,y]].hidden == false
                    (x-1..x+1).each do |i|
                    (y-1..y+1).each do |j|
                        if valid_pos([i,j])
                            self[[i,j]].reveal
                        end
                    end
                end
                end
            end
        end
    end

    def rows
        grid
    end





end