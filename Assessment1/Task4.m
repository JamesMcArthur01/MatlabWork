% MATLAB script for Assessment Item-1
% Task-4
%clear; close all; clc

%TASK 3 NEEDS TO BE RUN BEFORE RUNNING TASK 4

[B,L,N] = bwboundaries(Image); %b = boundary pixel locations, L = label matrix, N = num of objects
measurements = regionprops(Image, 'all');

plot_euclidean(B,N,measurements);
plot_radians(B,N);



function plot_euclidean(b, n, stats)
for k = 1:n
    subplot(1,2,1)
    title('Starfish Signatures (per boundary pixel)')
    c = stats(k).Centroid;
    bound = b{k};
    x = bound(:,1);
    y = bound(:,2);
    distances=sqrt((y-c(1)).^2+(x-c(2)).^2);
    t=1:1:length(distances);
    plot(t,distances);
    axis([0 250 0 50]);
    xlabel('Boundary Pixel');ylabel('Distance');
    legend('Star 1', 'Star 2', 'Star 3', 'Star 4', 'Star 5');
    hold on;
end
end

function plot_radians(b, n)
for j = 1:n
    subplot(1,2,2);
    title('Starfish Signatures (Rho and Theta)')
    region =(b{j});
    [th,r] = cart2pol(region(:,2) - mean(region(:,2)),...
        region(:,1) - mean (region(:,1)));
    plot(th,r);
    axis([-pi pi 0 50]);
    xlabel('Radians');ylabel('Distance');
    hold on;  
end

end

function [b] = plotBoundary(regions, num)
for i = 1:num    
    hold on;
    b = regions{i};
    plot(b(:,2),b(:,1),'r');
    hold on;
end
end


function[cent] = findCentroid(k)
for cent = 1: numel(k)
    plot(k(cent).Centroid(1),k(cent).Centroid(2),'ro');
end
end





