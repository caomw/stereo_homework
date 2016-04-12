function plot_3d(points_3d, R2, t2, I1, matches)
%PLOT_3D Summary of this function goes here
%   Detailed explanation goes here
    N = size(matches, 1);
    
    depth = points_3d(:, 3);
    depth = (depth - min(depth)) / (max(depth) - min(depth)) / 1.5;
    depth_colors = hsv2rgb([depth, ones(N, 2)]);
    
    colors = {'ob', 'og', 'oy', 'oc'};
    [h, w, ~] = size(I1);
    x1 = matches(:, 1);
    y1 = matches(:, 2);
    color_vec = 1 + (x1 > w/2) + 2*(y1 > h/2);
    
    figure;
    imshow(I1);
    hold on;
    for n = 1:N
      plot(x1(n), y1(n), 'o', 'MarkerSize', 20/points_3d(n, 3), 'MarkerEdgeColor', depth_colors(n, :));
    end
    
    figure;
    imshow(I1);
    hold on;
    for n = 1:N
      plot(x1(n), y1(n), colors{color_vec(n)}, 'MarkerSize', 20/points_3d(n, 3));
    end
    
    figure;
    hold on;
    O2 = -R2 \ t2;
    Ox = [0, O2(1)];
    Oy = [0, O2(2)];
    Oz = [0, O2(3)];
    x = points_3d(:, 1);
    y = points_3d(:, 2);
    z = points_3d(:, 3);
    
    scatter3(-Ox, -Oy, Oz, 'r');
%     scatter3( z,  x,  y, 'w'); hold on;
    %x = [points_3d(:, 1)', O2(1, 1)];
    %y = [points_3d(:, 2)', O2(2, 1)];
    %z = [points_3d(:, 3)', O2(3, 1)];

    for n = 1:N
      plot3(-x(n), -y(n), z(n), colors{color_vec(n)}, 'MarkerSize', 30/points_3d(n, 3));
    end
    
end
