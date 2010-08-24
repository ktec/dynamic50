require 'spec_helper'

module Graphics
  describe Editor do
    let(:output) { double('output').as_null_object }
    let(:editor) { Editor.new(output) }

    describe "#start" do
      it "sends a welcome message" do
        output.should_receive(:puts).with('Welcome to MS Graphical Editor 2010')
        editor.start
      end

      it "prompts for a command" do
        output.should_receive(:puts).with('What do you want to draw today?')
        editor.start
      end
    end
    
    describe "#command" do
      
      context "with the IMN command" do
        it "envokes the create image method with M,N" do
          editor.should_receive(:create_image).with(2,2)
          editor.command('I22')
        end
      end
      
      context "with a 5x6 image" do

        before :each do
          editor.command('I56')
        end
 
        it "has an image store with size MxN" do
          editor.image.should eql [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]]
        end
 
        context "with LXYC command" do
          it "colours the pixel (2,3) with colour 'A'" do
            editor.command('L23A')
            editor.get_pixel(2,3).should eql('A')
          end
        end
 
        context "with C command" do
          it "clear the table and set all pixels to white (0)" do
            editor.command('C')
            editor.image.should be_all { |row| 
              row.should be_all { |pixel| pixel == 0 }
            }
          end
        end

        context "with VXY1Y2C command" do
          it "draws a vertical segment of colour C in column X between Y1 and Y2 inclusive" do
            editor.command('C')
            editor.command('V234W')
            editor.image.should eql([[0,0,0,0,0],
                                     [0,0,0,0,0],
                                     [0,'W',0,0,0],
                                     [0,'W',0,0,0],
                                     [0,0,0,0,0],
                                     [0,0,0,0,0]])
            
          end
        end

        context "with HX1X2YC command" do
          it "draws a horizontal segment of colour C in row Y between X1 and X2 inclusive" do
            editor.command('C')
            editor.command('H342Z')
            editor.image.should eql([[0,0,0,0,0],
                                     [0,0,'Z','Z',0],
                                     [0,0,0,0,0],
                                     [0,0,0,0,0],
                                     [0,0,0,0,0],
                                     [0,0,0,0,0]])
            
          end
        end

        #context "with FXYC command" do
        #  it "fill the region R with colour C. R is defined as Pixel(X,Y) and any adjacent pixel with the same colour" do
        #    editor.command('C')
        #    editor.command('F33J')
        #    editor.image.should eql([[0,0,'J',0,0],
        #                             [0,0,'J',0,0],
        #                             ['J','J','J','J','J'],
        #                             [0,0,'J',0,0],
        #                             [0,0,'J',0,0],
        #                             [0,0,'J',0,0]])
        #    
        #  end
        #end
        
        describe "#set_pixel" do
          it "sets the colour of 2,2 to A" do
            editor.set_pixel(2,2,'A')
            editor.image[1][1].should eql('A')
          end
          it "sets the colour of 2,2 to 0" do
            editor.set_pixel(2,2,0)
            editor.image[1][1].should eql(0)
          end
        end
        
        context "and bottom right is A" do

          before :each do
            editor.set_pixel(2,2,'A')
          end

          describe "#get_pixel" do
            it "returns the bottom right" do
              editor.get_pixel(2,2).should eql('A')
            end
            it "returns the top left" do
              editor.get_pixel(1,1).should eql(0)
            end
          end
        end

      end
      
    end
  end
end