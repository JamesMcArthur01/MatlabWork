% MATLAB script for Assessment Item-1
% Task-1
clear; close all; clc;

I = imread('Zebra.jpg');

%Convert to grayscale
Igray = rgb2gray(I);

%Perform Bilinar Interpolation to resize image (see code below)
bilin = bilinearInterpolation(Igray, [1668 1836]);

subplot(2,2,[1 3])
imshow(Igray)
title('Original Image');

subplot(2,2,2)
imshow(bilin)
title('Bilinear Interpolation Image');

%Perform Nearest Neighbour to resize image (see code below)
nn = nearestNeighbour(Igray, [1668 1836]);
subplot(2,2,4)
imshow(nn)
title('Nearest Neighbour Image');

function [S] = bilinearInterpolation(I, out_dims)
    %No. of rows/columns in input image (556 x 612)
    [f_y, f_x] = size(I);
    %No. of rows in output image (1668)
    g_y = out_dims(1);
    %No of columns in output image (1836)  
    g_x = out_dims(2);  
    
    %Scale factors i.e. 556 / 1668 (input image has ~33.3% of spatial resolution of output image, or a ratio of 0.3333)
    s_r = f_y / g_y; 
    s_c = f_x / g_x; 
    
    %presents spatial domain for new image as cartesian grid
    [cf, rf] = meshgrid(1 : g_x, 1 : g_y); 
    
    %multiply dimensions of new image by scale factor to introduce fractional resizing
    rf = rf * s_r;   
    cf = cf * s_c; 
    
    %convert continuous values of (rf,cf) into discrete values for (r,c)
    r = floor(rf);
    c = floor(cf);

    %Cap any values that are out of range
    r(r < 1) = 1;
    c(c < 1) = 1;
    r(r > f_y - 1) = f_y - 1;
    c(c > f_x - 1) = f_x - 1;

    %The difference between both values(i.e. y2 - y1 / x2 - x1)
    a = rf - r;
    b = cf - c;

    %Assign linear index equivalents to the row and column subscripts r and
    %c for size of input image
    Q11 = sub2ind([f_y, f_x], r, c); %[i,j] Q11
    Q21 = sub2ind([f_y, f_x], r+1,c); %[i+1,j] Q21
    Q12 = sub2ind([f_y, f_x], r, c+1); %[i,j+1] Q12
    Q22 = sub2ind([f_y, f_x], r+1, c+1); %[i+1,j+1] Q22     

    %Create output size, data type and colour channels
    S = zeros(g_y, g_x, size(I, 3));
    S = cast(S, class(I));
    
    position = double(I(:,:));
    %Find value of P relative to values at each position in input using
    %calculated weight
    P = position(Q11).*(1 - a).*(1 - b) + ...
        position(Q21).*(a).*(1 - b) + ...
        position(Q12).*(1 - a).*(b) + ...
        position(Q22).*(a).*(b);
    
    %Return interpolated image
    S(:,:) = cast(P, class(I));      
end

function[S] = nearestNeighbour(I,out_dims)

[r, c] = size(I); %size of original image
S_r = out_dims(1); %size of scaled image (rows) 
S_c = out_dims(2); %size of scaled image (cols) 

%scaled image, including dimensions and class(i.e.uint8)
S = zeros(S_r, S_c, class(I)); 

for i = 1:S_r 
    for j = 1:S_c
        
        %resample pixel values according to scale of output image
        ii = round((i-1) * (r - 1) / S_r + 1);
        jj = round((j-1) * (c - 1) / S_c + 1);
        
        S(i,j) = I(ii,jj);
    end
end
end




