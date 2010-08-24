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
 
        context "with S command" do
          it "sends the image to output" do
            output.should_receive(:puts).with("00000\n00000\n00000\n00000\n00000\n00000\n")
            editor.command('S')
          end
        end
        
        context "with LXYC command" do
          it "colours the pixel (2,3) with colour 'A'" do
            output.should_receive(:puts).with("00000\n00A00\n00000\n00000\n00000\n00000\n")
            editor.command('L23A')
            editor.command('S')
          end
        end
 
        context "with C command" do
          it "clear the table and set all pixels to white (0)" do
            output.should_receive(:puts).with("00000\n00000\n00000\n00000\n00000\n00000\n")
            editor.command('C')
            editor.command('S')
          end
        end

        context "with VXY1Y2C command" do
          it "draws a vertical segment of colour C in column X between Y1 and Y2 inclusive" do
            editor.command('C')
            output.should_receive(:puts).with("00000\n00000\n0W000\n0W000\n00000\n00000\n")
            editor.command('V234W')
            editor.command('S')
          end
        end

        context "with HX1X2YC command" do
          it "draws a horizontal segment of colour C in row Y between X1 and X2 inclusive" do
            editor.command('C')
            output.should_receive(:puts).with("00000\n00ZZ0\n00000\n00000\n00000\n00000\n")
            editor.command('H342Z')
            editor.command('S')
          end
        end

        context "with FXYC command" do
          it "fill the region R with colour C. R is defined as: Pixel (X,Y) belongs to R. Any other pixel which is the same colour as (X,Y) and shares a common side with any pixel in R also belongs to this region" do
            output.should_receive(:puts).with("JJJJJ\nJJJJJ\nJJJJJ\nJJJJJ\nJJJJJ\nJJJJJ\n")
            editor.command('F33J')
            editor.command('S')
          end
        end

      end
      
    end
  end
end