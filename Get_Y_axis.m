function [ s,r ] = Get_Y_axis( I )
I=rgb2gray(I);
maxY=0;
results = ocr(I,'TextLayout','Block');
numbers = str2double(regexp(results.Text, '\d+', 'match'));

max_numbers = max(numbers);
N_size=size(results.Words);


  for i=1:N_size(1)
    if strcmp(results.Words(i),num2str(max_numbers))==1
         maxY=results.WordBoundingBoxes(i,2);
         break;
    end
  end
   
  
s=maxY+15;
r=max_numbers;
end

