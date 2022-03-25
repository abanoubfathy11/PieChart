function [ s ] = BarChart( I )
%EDGEBASED Summary of this function goes here
%   Detailed explanation goes here

II=I;
[topColor,max_numbers]=Get_Y_axis(I);
I=PreProcessing(I);
x = rgb2gray(I);
%figure,imshow(uint8(x));
BW = edge(x,'canny');
se = strel('sphere', 1);
BW = imdilate(BW,se);
BW = ~BW;
[L, num] = bwlabel(BW);
RGB = label2rgb(L);

[h, w, ~] = size(I);
smallRatio = h*w*0.002;
eachColor=[];
%fig=[]
ColorPixels=0;
oneColorinterval=0;
buttonColor=0;
colorz=[];
for i=1:num

    x = uint8(L==i);
    f = sum(sum(x==1));
    if(f < smallRatio)
        continue;
    end
    d = ones(size(I));
    d(:,:,1) = uint8(x).*I(:,:,1);
    d(:,:,2) = uint8(x).*I(:,:,2);
    d(:,:,3) = uint8(x).*I(:,:,3);
    cnt=0;
    
    maxSize=(h*w)/2;
    for o=1:h
        for p=1:w
            if d(o,p,1)>=255 && d(o,p,2)>=255 &&d(o,p,3)>=255
                cnt=cnt+1;
            end
        end
    end

    if(cnt> 100 )
        continue;
    else
        oneColorinterval=0;
       
       [h, w, ~]=size(d);
        
        redChannel=0;
        greenChannel=0;
        blueChannel =0;
        flag=0;
        
        
        for l=1:h
            for k=1:w     
                if uint8(d(l,k,1))>0 || uint8(d(l,k,2))>0 || uint8(d(l,k,3))>0   
                    redChannel = d(l, k, 1);
                    greenChannel = d(l, k, 2);
                    blueChannel = d(l, k, 3); 
                    flag=1;
                    break;
                end
                if flag==1
                    break;
                end
            end
            
        end
        colorz=[colorz,redChannel greenChannel blueChannel];  
        grayIm=rgb2gray(uint8(d));
        grayIm=medfilt2(grayIm,[4,4]);
        grayIm=imsharpen(grayIm,'Radius',5,'Amount',3);
      
        
        [h, w, ~] = size(grayIm);
        test=0;
         for m=1:h
            for n=1:w
                
                if grayIm(m,n,:) ~= 0
                     oneColorinterval=m;
                     test=1;
                     break;
                  
                end
            end
            if test==1
                break;
            end
         end
         test=0;
          for m=h:-1:1
            for n=w:-1:1
                
                if grayIm(m,n,:) ~= 0
                    buttonColor=m;
                    test=1;
                    oneColorinterval=m-oneColorinterval;
                    break;
                  
                end
            end
            if test ==1
                break;
            end
         end


         eachColor=[eachColor,oneColorinterval];
        
    end
   
end
eachColor;
Y=buttonColor-topColor;
final_result=[];
value=0;
[dim1,dim2]=size(eachColor);
    for i=1:dim2-1
         value=((eachColor(i)*max_numbers)/Y);
         value=round(value);
         if (value<=max_numbers)
             final_result=[final_result,value];
         end
    end
value=((eachColor(dim2)*max_numbers)/Y);
value=floor(value);
final_result=[final_result,value];
final_result
s=I;
x=Map_Bar(II,colorz,final_result);
end

