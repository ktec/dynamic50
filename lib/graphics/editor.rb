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
        w,h = arr.map(&:to_i)
        create_image(w,h)
      when "L":
        x,y = arr[0..1].map(&:to_i)
        col = arr[2]
        set_pixel(x,y,col)
      when "V"
        x,y1,y2 = arr[0..2].map(&:to_i)
        col = arr[3]
        (y1..y2).each{|y| set_pixel(y,x,col) }
      when "H"
        x1,x2,y = arr[0..2].map(&:to_i)
        col = arr[3]
        (x1..x2).each{|x| set_pixel(y,x,col) }
      when "F"
        x,y = arr[0..2].map(&:to_i)
        col = arr[2]
        fill(x,y,col)
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
      @width = w
      @height = h
      @image = Array.new(@height){Array.new(@width).fill(0)}
    end
    
    def set_pixel(x,y,col)
      x,y = x-1, y-1 # normalise the values
      row = @image[x]
      row[y] = col if row
    end

    def fill(x,y,newCol,origCol=nil)
      if in_range?(x,y)
        origCol = get_pixel(x,y) if origCol.nil?
        set_pixel(x,y,newCol)
        [[x-1,y-1],
         [x,y-1],
         [x+1,y-1],
         [x-1,y],
         [x+1,y],
         [x-1,y+1],
         [x,y+1],
         [x+1,y+1]].each { |x,y|
          fill?(x,y,newCol,origCol)
        }
      end
    end
    
    def fill?(x,y,newCol,origCol)
      if in_range?(x-1,y-1)
        col = get_pixel(x,y)
        if (col != newCol && col == origCol)
          fill (x,y,newCol,origCol)
        end
      end
    end
    
    def in_range?(x,y)
      (x>=0 && y>=0 && x <= @height && y <= @width)
    end
    
    def get_pixel(x,y)
      row = @image[x-1]
      row[y-1] if row
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
