require 'colorize'
class Tile
    attr_reader :mine, :hidden, :flag
    attr_accessor :fringle, :highlight
    #value present have boom or not
    def initialize(value)
        @mine = value
        @hidden = true
        @flag = false
        @fringle = 0
        @highlight = false
    end

    def to_s
        if highlight
        if hidden
                 flag ? "[F]".colorize(:background => :yellow) : "[_]".colorize(:background => :green)
            else
                if mine
                    "[M]".colorize(:background => :red)
                else
                    fringle == 0 ? "[*]".colorize(:background => :green) : "[#{fringle}]".colorize(:background => :blue) 
                end    
            end
        else
            if hidden
                 flag ? "[F]".colorize(:yellow) : "[_]"
            else
                if mine
                    "[M]".colorize(:red)
                else
                    fringle == 0 ? "[*]".colorize(:green) : "[#{fringle}]".colorize(:blue) 
                end    
            end
        end
         
    end
    def change_flag
        if hidden == false
            puts "you can not flag square that already reveal"
        else
         flag ? @flag = false : @flag = true   
        end
    end
   def reveal
       flag ? (puts "you should unflag it before reveal") : @hidden = false
   end
   def force_reveal
        @hidden = false  
   end

   def clear?
       mine == flag
   end
    #what fuction that tile have
    #to_s = to help the render
    #change the status of hidden 


end