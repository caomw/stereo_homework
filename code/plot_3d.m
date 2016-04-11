function plot_3d(points_3d, R2, t2)
%PLOT_3D Summary of this function goes here
%   Detailed explanation goes here
    figure;
    O2 = -inv(R2)*t2; 
    %x = [points_3d(:, 1)', O2(1, 1)];
    %y = [points_3d(:, 2)', O2(2, 1)];
    %z = [points_3d(:, 3)', O2(3, 1)];
    x = points_3d(:, 1);
    y = points_3d(:, 2);
    z = points_3d(:, 3);
    scatter3(x,y,z); hold on;
    scatter3([0, O2(1, 1)], [0, O2(2, 1)], [0, O2(3, 1)], 30, 'r');
end

