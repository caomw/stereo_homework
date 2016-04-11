function [R_cell, t_cell] = find_rotation_translation(E)

[U, ~, V] = svd(E);
R90 = [0, 1, 0; -1, 0, 0; 0, 0, 1];

R = (V \ R90 * U')';
t = U(:, end);

R_cell = {R, -R};
t_cell = {t, -t};

% Tx = [    0, -t(3),  t(2);
%        t(3),     0, -t(1);
%       -t(2),  t(1),     0];

end
