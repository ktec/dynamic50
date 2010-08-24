module Graphics
  class Editor

    def initialize(output)
      @output = output
    end
    
    def start
      @output.puts 'Welcome to MS Graphical Editor 2010'
      @output.puts 'What do you want to draw today?'
    end
    
    def command(string)
      arr = string.split("")
      case arr.shift # first character
      when "I":
        w,h = arr[0].to_i,arr[1].to_i
        create_image(w,h)
      when "L":
        x,y,col = arr[0].to_i,arr[1].to_i,arr[2]
        set_pixel(x,y,col)
      when "V"
        x,y1,y2,col = arr[0].to_i,arr[1].to_i,arr[2].to_i,arr[3]
        (y1..y2).each{|y| set_pixel(y,x,col) }
      when "H"
        x1,x2,y,col = arr[0].to_i,arr[1].to_i,arr[2].to_i,arr[3]
        (x1..x2).each{|x| set_pixel(y,x,col) }
      when "F"
        ## AMBIGIOUS QUESTION!!!
        x1,y1,col = arr[0].to_i,arr[1].to_i,arr[2]
        original_col = get_pixel(x1,y1)
        set_pixel(x1,y1,col)
        @image.each_with_index {|x,xi|
          x.each_with_index {|y,yi|
            set_pixel(xi,yi,col) if (xi=x1 || yi=x1) # || y = original_col
          }
        }
      when "S":
        paint
      when "X":
        exit
      when "C":
        clear
      end
    end
    
    def image
      @image
    end
    
    def create_image(w,h)
      @image = Array.new(h){Array.new(w).fill(0)}
    end
    
    def set_pixel(x,y,colour)
      @image[x-1][y-1] = colour
    end
    
    def get_pixel(x,y)
      @image[x-1][y-1]
    end
    
    def clear
      @image.each { |row|
        row.fill(0)
      }
    end
    
    def paint
      @image.each { |row|
        puts row.join("")
      }
    end
    
  end
end
