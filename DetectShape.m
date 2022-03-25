function [ out ] = DetectShape( image )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
I=image;
[YPixels,y]=Get_Y_axis(I);
if YPixels<=35
    out=PieChart(I);
else
    out=BarChart(I);
end
end

