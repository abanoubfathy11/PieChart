function [ s ] = PieChart( I )


grayImage = rgb2gray(I);
BW = edge(grayImage,'canny');
se = strel('sphere', 8);
BW = imdilate(BW,se);
BW = ~BW;
[L, num] = bwlabel(BW);
RGB = label2rgb(L);
[h, w, ~] = size(I);
smallRatio = h*w*0.002;

eachColor=[];
colorz=[];
ColorPixels=0;
oneColor=0;
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
    
    for o=1:h
        for p=1:w
            if d(o,p,1)>=250 && d(o,p,2)>=250 &&d(o,p,3)>=250
                cnt=cnt+1;
            end
        end
    end
    
    if(cnt> 100 )
        continue;
    else
        oneColor=0;

        [h, w, ~]=size(d);
        
        redChannel=0;
        greenChannel=0;
        blueChannel =0;
        flag=0;
        %figure,imshow(uint8(d));
        
        for l=1:h
            for k=1:w     
                if d(l,k,1)>0 || d(l,k,2)>0 || d(l,k,3)>0   
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

      
        d=imgaussfilt(d,5);
        d=imsharpen(d,'Radius',5,'Amount',1);
        ColorPixels=ColorPixels+sum(d(:) ~= 0);
        oneColor = sum(d(:) ~= 0);
        
        eachColor=[eachColor,oneColor];
        colorz=[colorz,redChannel greenChannel blueChannel];
    end
   
end

s=1;
eachColor=round((eachColor/ColorPixels)*100,2)

x=Map(I,colorz,eachColor);
end

