function Mi = blockinv(M, subsizes, skipcheck)
% BLOCKINV invert matrix M by breaking it into sub-matrices and applying the block-matrix-inversion
% algorithm.
% Implementation Details
% ----------------------
%
% See https://en.wikipedia.org/wiki/Block_matrix#Block_matrix_inversion : Any matrix,
% broken down into blocks as [A B; C D] has an inverse that can be written [W X; Y Z]
% with
%
%   W = inv(A) + inv(A) B inv(D - C inv(A) B) C inv(A)
%   X = -inv(A) B inv(D - C inv(A) B)
%   Y = -inv(D - C inv(A) B) C inv(A)
%   Z = inv(D - C inv(A) B)
%
% ...or, in a more efficient order
%
%   Z = inv(D - C inv(A) B)
%   X = -inv(A) B Z
%   Y = -Z C inv(A)
%   W = inv(A) - X C inv(A)
%
% So, the main components are inv(A), and Z = inv(D - C inv(A) B), which is computed recursively.
if nargin < 3 || ~skipcheck
    assert(ismatrix(M));
    assert(sum(subsizes) == size(M, 1) && size(M, 1) == size(M, 2));
end
if length(subsizes) == 1
    % Base case - result is simply inverse of A. Note: use mldivide to get inverse, since mldivide
    % contains smart handling of matrices with special structure like diagonal or upper-triangular
    % matrices.
    Mi = M \ speye(size(M));
else
    % Recursive case - apply formula above
    
    % Extract sub-matrices A, B, C, D
    sub1 = subsizes(1);
    
    A = M(1:sub1, 1:sub1);
    B = M(1:sub1, sub1+1:end);
    C = M(sub1+1:end, 1:sub1);
    D = M(sub1+1:end, sub1+1:end);
    
    % Compute results W, X, Y, Z
    
    invA = A \ speye(size(A));
    AiB = A \ B;
    CAi = C / A;
    Z = blockinv(D - C * (A \ B), subsizes(2:end), true); % recurse
    Y = -Z * CAi;
    X = -AiB * Z;
    W = invA - X * CAi;
    
    % Create output
    Mi = [W X; Y Z];
end
end