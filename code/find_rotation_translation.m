function [R_cell, t_cell] = find_rotation_translation(E)

[U, ~, V] = svd(E);
RP90 = [0, -1, 0; +1, 0, 0; 0, 0, 1];
RN90 = [0, +1, 0; -1, 0, 0; 0, 0, 1];

R1 = U * RP90' * V';
R2 = U * RN90' * V';

t = U(:, end);

R_cell = {R1, -R1, R2, -R2};
t_cell = {t, -t};

% Tx = [    0, -t(3),  t(2);
%        t(3),     0, -t(1);
%       -t(2),  t(1),     0];
% E_ref = Tx * R1;
% E_ref = E_ref / sum(E_ref(:)) * sum(E(:));

end
