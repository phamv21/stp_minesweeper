require 'io/console'
class Keypress
# Reads keypresses from the user including 2 and 3 escape character sequences.
def self.read_char
  STDIN.echo = false
  STDIN.raw!

  input = STDIN.getc.chr
  if input == "\e" then
    input << STDIN.read_nonblock(3) rescue nil
    input << STDIN.read_nonblock(2) rescue nil
  end
ensure
  STDIN.echo = true
  STDIN.cooked!

  return input
end

def self.pos_control
     c = Keypress.read_char
respond = '' 
    case c
     when "\e[A"
    respond = "UP"
    when "\e[B"
    respond = "DOWN"
    when "\e[C"
    respond = "RIGHT"
    when "\e[D"
    respond = "LEFT"
     when "\r"
    respond = "RETURN"
    when "f"
    respond = "F"
    when "r"
    respond = "R"
    when "s"
    respond = "S"
    else
    respond = ''
    end
respond

end
def self.decision_control
    c = Keypress.read_char
respond = '' 
    case c
     when "f"
    respond = "F"
    when "r"
    respond = "R"
    when "s"
    respond = "S"
    when "\e"
    respond = "ESCAPE"
    else
    respond = ''
    end
respond
end

# oringal case statement from:
# http://www.alecjacobson.com/weblog/?p=75
def show_single_key
  c = read_char

  case c
  when " "
    puts "SPACE"
  when "\t"
    puts "TAB"
  when "\r"
    puts "RETURN"
  when "\n"
    puts "LINE FEED"
  when "\e"
    puts "ESCAPE"
  when "\e[A"
    puts "UP ARROW"
  when "\e[B"
    puts "DOWN ARROW"
  when "\e[C"
    puts "RIGHT ARROW"
  when "\e[D"
    puts "LEFT ARROW"
  when "\177"
    puts "BACKSPACE"
  when "\004"
    puts "DELETE"
  when "\e[3~"
    puts "ALTERNATE DELETE"
  when "\u0003"
    puts "CONTROL-C"
    exit 0
  when /^.$/
    puts "SINGLE CHAR HIT: #{c.inspect}"
  else
    puts "SOMETHING ELSE: #{c.inspect}"
  end
end
#show_single_key while(true)
end