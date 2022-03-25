function [ s ] = Map_Bar(ii,colors,per )
%MAP_BAR Summary of this function goes here
%   Detailed explanation goes here
I=ii;
colorz=colors;
eachColor=per;
LengthOfPerc=length(per);
BW = rgb2gray(I);
BW = BW < 20;
BW = imclearborder(~BW);
BW = bwareafilt(BW,1);
s = regionprops(BW,'BoundingBox');
Icropped = imcrop(I,s.BoundingBox);
[h,w,~]=size(Icropped);
[hh ww ~]=size(Icropped);
if h==0
    BW = rgb2gray(I);
    BW = BW < 155;
    BW = imclearborder(~BW);
    BW = bwareafilt(BW,1);
    s = regionprops(BW,'BoundingBox');
    Icropped = imcrop(I,s.BoundingBox);
    [h, w,~]=size(Icropped);
end
[h,w,~]=size(Icropped);
[hh ww ~]=size(Icropped);
L=length(eachColor);
rgbRed=0;
rgbGreen=0;
rgbBlue=0;

redCounter=1;
GreenCounter=2;
BlueCounter=3;

r=1;
g=2;
b=3;
widthXAxis=[];

for yyyyyy=1:LengthOfPerc
    tflag=0;
    for i=1:h
        for j=1:w
            if Icropped(i,j,1) <= colorz(r)+10 && Icropped(i,j,1) >= colorz(r)-10 && Icropped(i,j,2) >= colorz(g)-10 &&Icropped(i,j,2) <= colorz(g)+10 && Icropped(i,j,3) >= colorz(b)-10&& Icropped(i,j,3) <= colorz(b)+10
                widthXAxis=[widthXAxis,j];
                tflag=1;
                break;
            end
            if tflag==1
                break;
            end
        end
    end
    r=r+3;
    g=g+3;
    b=b+3;
end
 widthXAxis;

 lenOrbitLegned=hh/LengthOfPerc;
    for percent=1:L
        
        rgbRed=colorz(redCounter);
        rgbGreen=colorz(GreenCounter);
        rgbBlue=colorz(BlueCounter); 
        flagg=0;
        legend=Icropped;
        for i=1:hh
            for j=1:ww
                if legend(i,j,1) <= rgbRed+20 && legend(i,j,1) >= rgbRed-20 && legend(i,j,2) >= rgbGreen -20 &&legend(i,j,2) <= rgbGreen+20 && legend(i,j,3) >= rgbBlue-20&& legend(i,j,3) <= rgbBlue+20 
                        [hh ww ~]=size(legend);
                        str=[hh ww];
                        
                        topRow=i-5;
                        if LengthOfPerc>7
                            if percent >1
                                topRow=lenOrbitLegned*(percent-1);
                            else
                                topRow=0;
                            end
                            leftColumn=j-2;
                            width = ww;
                            height=lenOrbitLegned;
                            
                        else
                            if hh>ww
                            leftColumn=j+7;
                            width = ww;
                            height=hh/LengthOfPerc;
                            else
                                leftColumn=j+5;
                                width =GreaterThanLowerAll(widthXAxis,j,ww);
                                height=hh;
                            end
                        end
                       
                       
                        legend=imcrop(legend,[leftColumn,topRow,width,height]);
                        figure,imshow(legend),title(eachColor(percent));
                        
                        flagg=1;
                        break;
                end
            end
            if flagg==1
                break;
            end
        end
        
        redCounter=redCounter+3;
        GreenCounter=GreenCounter+3;
        BlueCounter=BlueCounter+3;
        
    end
s=I;

end

