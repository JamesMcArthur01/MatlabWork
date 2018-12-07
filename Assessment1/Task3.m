% MATLAB script for Assessment Item-1
% Task-3
clear; close all; clc;

I = imread('Starfish.jpg');
subplot(2, 3, 1);
imshow(I);
title('Original Image'); %READ IN AND DISPLAY ORIGINAL

%Iterate through each rgb channel and apply medfilt2 function to reduce
%noise in input image
I = removeNoise(I);
subplot(2, 3, 2);
imshow(I)
title('Image with median filter');

%apply unsharp masking to improve the edges of the image
I = imsharpen(I, 'amount', 1.5);
I = rgb2gray(I);
subplot(2, 3, 3);
imshow(I)
title('Unsharp masking + convert to grey');

%Apply a custom thresholding function to convert values inside bounds to
%white and all others to black
I = threshold(I,190, 220);
subplot(2, 3, 4);
imshow(I)
title('Thresholded');

%reduce holes in the image
I = imfill(I, 'holes'); 
 %dilation then erosion
I = imclose(I,strel('disk', 2));
%removessmall objects with fewer than n pixels
I = bwareaopen(I,800); 
subplot(2, 3, 5);
imshow(I)

%find connected componenets in I (returns struct)
cc = bwconncomp(I,8); 


k = regionprops(cc, 'all'); 
%find each starfish based on shared properties
star = find([k.MajorAxisLength] > 56.5 & [k.MajorAxisLength] < 77.5 &...
           [k.MinorAxisLength] > 37 & [k.MinorAxisLength] < 50 &...
           [k.Eccentricity] > 0.5000 & [k.Eccentricity] < 0.8000 &...
           [k.ConvexArea] > 2000 & [k.ConvexArea] < 3200 &...
           [k.EquivDiameter] > 30 & [k.EquivDiameter] < 40 &...
           [k.Solidity] > 0.3500 & [k.Solidity] < 0.4500 &...
           [k.Extent] > 0.2000 & [k.Extent] < 0.3000 &...
           [k.Perimeter] > 250 & [k.Perimeter] < 350);

%return true if starfish       
Image = ismember(labelmatrix(cc), star); 

%Apply dilation and erosion to clear the image
Image = imdilate(Image, strel('square', 5));
Image = imerode(Image, strel('disk', 2));
subplot(2, 3, 6);
imshow(Image)



function[f] = removeNoise(I)

for colour = 1:size(I,3)
    f(:,:,colour) = medfilt2(I(:,:,colour));
end
end

function[g] = threshold(I, lower, upper)

for r = 1:size(I,1)
    for c = 1:size(I,2)
        if I(r,c) >= lower && I(r,c) <= upper
            g(r,c)=255;
        else
            g(r,c) = 0;
        end
    end
end
end


