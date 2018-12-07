% MATLAB script for Assessment Item-1
% Task-2
clear;
clc;

im = im2double(imread('Noisy.png'));

im = rgb2gray(im);

medI = medianFilter(im, 5);
meanI = meanFilter(im, 5);

subplot(2,2,[1 3])
imshow(im)
title('Original Image')

subplot(2,2,2)
imshow(medI)
title('Median Filter')

subplot(2,2,4)
imshow(meanI)
title('Mean Filter')


function[s] = meanFilter(I, N) 
%Dimensions of input image
[r, c] = size(I);

padding = N-1; %(i.e. 4)

%apply N-1 padding to row and column output
img = zeros(r+padding, c+ padding);

%i.e. img(3:476, 3:758) = I
img(padding/2+1:r+padding/2, padding/2+1:c+padding/2) = I;

s = zeros(r,c);

%Find the mean within each window of f(x,y) and assign it to position in g(x,y)
for x = padding/2 + 1: c + padding/2
    for y = padding/2 + 1 : r + padding/2
        win = img(y-padding/2:y+padding/2, x-padding/2:x+padding/2);
        s(y-padding/2, x-padding/2) = mean(win(:));
    end
end
end


function[s] = medianFilter(I, N)

%Dimensions of input image
[r, c] = size(I); 

padding = N-1; %(i.e. 4)

%apply N-1 padding to row and column output
img = zeros(r+padding, c+ padding); 

%img(3:476, 3:758
img(padding/2+1:r+padding/2, padding/2+1:c+padding/2) = I; 

s = zeros(r,c);

%Find the median within each window of f(x,y) and assign it to position in g(x,y)
for x = padding/2 + 1: c + padding/2 
    for y = padding/2 + 1 : r + padding/2 
        win = img(y-padding/2:y+padding/2, x-padding/2:x+padding/2); 
        s(y-padding/2, x-padding/2) = median(win(:));
    end
end
end

    


