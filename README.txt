Stories


0. Starts the session
1. I M N. Create a new M x N image with all pixels coloured white (O).
2. C. Clears the table, setting all pixels to white (O).
3. L X Y C. Colours the pixel (X,Y) with colour C.
4. V X Y1 Y2 C. Draw a vertical segment of colour C in column X 
   between rows Y1 and Y2 (inclusive).
5. H X1 X2 Y C. Draw a horizontal segment of colour C in row Y 
   between columns X1 and X2 (inclusive).
6. F X Y C. Fill the region R with the colour C. 
   R is defined as: Pixel (X,Y) belongs to R. 
   Any other pixel which is the same colour as (X,Y) and 
   shares a common side with any pixel in R also belongs to this region.
7. S. Show the contents of the current image 
8. X. Terminate the session