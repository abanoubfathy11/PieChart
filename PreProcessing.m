function [ s ] = PreProcessing( I )

[h, w, ~] = size(I);
for o=1:h
        for p=1:w
            if ( I(o,p,1)<=153 && I(o,p,2)==255 && I(o,p,3)==255 ) 
                 I(o,p,:)=255;
            end
        end
end
%figure,imshow(uint8(I));
redChannel = I(:, :, 1);
greenChannel = I(:, :, 2);
blueChannel = I(:, :, 3);

redMF = medfilt2(redChannel, [13 13]);
greenMF = medfilt2(greenChannel, [12 12]);
blueMF = medfilt2(blueChannel, [12 12]);

I(:, :, 1)=redMF;
I(:, :, 2)=greenMF;
I(:, :, 3)=blueMF;

s=I;
end

