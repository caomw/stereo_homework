function [ points_3d rec_err ] = find_3d_points(matches, P1, P2)
%FIND_3D_POINTS Summary of this function goes here
%   given camera matrices P1, P2, and matched points in both images
%   return points' 3d coordinates and recontruction error
    N = size(matches, 1); % number of pairs of points
    points_3d = zeros(N, 3);
    rec_err = 0;
    for i = 1:N
        x1 = matches(i, 1);
        y1 = matches(i, 2);
        x2 = matches(i, 3);
        y2 = matches(i, 4);
        % construct matrix 
        A = [P1(3, 1)*x1 - P1(1, 1), P1(3, 2)*x1 - P1(1, 2), P1(3, 3)*x1 - P1(1, 3);
            P1(3, 1)*y1 - P1(2, 1), P1(3, 2)*y1 - P1(2, 2), P1(3, 3)*y1 - P1(2, 3);
            P2(3, 1)*x2 - P2(1, 1), P2(3, 2)*x2 - P2(1, 2), P2(3, 3)*x2 - P2(1, 3);
            P2(3, 1)*y2 - P2(2, 1), P2(3, 2)*y2 - P2(2, 2), P2(3, 3)*y2 - P2(2, 3)];
        %[r, c] = size(A);
        %fprintf('size = %d %d\n', r, c);
        b = [P1(1, 4) - P1(3, 4)*x1; P1(2, 4) - P1(3, 4)*y1; P2(1, 4) - P2(3, 4)*x2; P2(2, 4) - P2(3, 4)*y2];
        % solve linear least square
        points_3d(i, :) = inv(A'*A)*A'*b;
        project1 = P1 * [points_3d(i, :), 1]';
        project1_2d = [project1(1)/project1(3), project1(2)/project1(3)];
        project2 = P2 * [points_3d(i, :), 1]';
        project2_2d = [project2(1)/project2(3), project2(2)/project2(3)];
        rec_err = rec_err + norm(project1_2d - matches(i, 1:2)) + norm(project2_2d - matches(i, 3:4));
    end
    % sanity check using pair 1
    %disp(points_3d(1, :));
    %project1 = P1 * [points_3d(1, :), 1]';
    %project1_2d = [project1(1)/project1(3), project1(2)/project1(3)];
    %disp(project1_2d);
    %disp(matches(1, 1:2));
    %disp(norm(matches(1, 1:2) - project1_2d));
    %fprintf('-------\n');
    %project2 = P2 * [points_3d(1, :), 1]';
    %project2_2d = [project2(1)/project2(3), project2(2)/project2(3)];
    %disp(project2_2d);
    %disp(matches(1, 3:4));
    %disp(norm(matches(1, 3:4) - project2_2d));
    rec_err = rec_err / (N * 2);
end

