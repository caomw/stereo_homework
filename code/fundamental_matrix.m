function [F, res_err] = fundamental_matrix(matches)
% implements the eight-point algorithm

N = size(matches, 1);
X1 = matches(:, 1);
Y1 = matches(:, 2);
X2 = matches(:, 3);
Y2 = matches(:, 4);

% normalization
uX1 = mean(X1);
uY1 = mean(Y1);
uX2 = mean(X2);
uY2 = mean(Y2);
sX1 = std(X1);
sY1 = std(Y1);
sX2 = std(X2);
sY2 = std(Y2);
X1 = (X1 - uX1) / sX1; 
Y1 = (Y1 - uY1) / sY1;
X2 = (X2 - uX2) / sX2;
Y2 = (Y2 - uY2) / sY2;
T1 = [ 1/sX1, 0, -uX1/sX1; 0, 1/sY1, -uY1/sY1; 0, 0, 1];
T2 = [ 1/sX2, 0, -uX2/sX2; 0, 1/sY2, -uY2/sY2; 0, 0, 1];

% least squre to estimate F
A = [X1.*X2, Y1.*X2, X2, X1.*Y2, Y1.*Y2, Y2, X1, Y1, ones(N, 1)];
[~, S, V] = svd(A, 0);
f = V(:, end);
F = reshape(f, 3, 3)';

% guarantee that rank(F) == 2
[U, S, V] = svd(F);
S(3) = 0;
F = U*S*V';

% denormalization
F = T2'*F*T1;

% compute reconstruction error
res_err = 0;
for n = 1:N
  x1 = [matches(n, 1:2), 1]';
  x2 = [matches(n, 3:4), 1]';
  % TODO check the order of x1 and x2 here. Ask GSI?
  dot = abs(x2' * F * x1)^2;
  d1 = (F'*x2);
  d2 = (F *x1);
  res_err = res_err + dot / (d1'*d1) + dot / (d2'*d2);
end
res_err = res_err / (2*N);

end
