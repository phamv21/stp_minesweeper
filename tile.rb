class Tile
    attr_reader :mine, :hidden, :flag
    attr_accessor :fringle
    #value present have boom or not
    def initialize(value)
        @mine = value
        @hidden = true
        @flag = false
        @fringle = 0
    end

    def to_s
        if hidden
             flag ? "[f]" : "[ ]"
        else
            if mine
                "[m]"  
            else
                fringle == 0 ? "[*]" : "[#{fringle}]" 
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

   def clear?
       mine == flag
   end
    #what fuction that tile have
    #to_s = to help the render
    #change the status of hidden 


end