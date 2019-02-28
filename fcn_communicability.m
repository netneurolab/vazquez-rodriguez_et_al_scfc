function G = communicability(A)
%
% COMMUNICABILITY(A) computes the communicability of pairs of nodes in the
% network represented by the unweighted adjacency matrix A. It returns a matrix
% whose elements G(i,j) = G(j,i) give the the communicability between nodes i
% and j.
%
% Author:
%     Bratislav Mišić
%
% References:
%     Estrada, E., & Hatano, N. (2008). Communicability in complex networks.
%     Physical Review E, 77(3), 036111.
%

G = expm(A);    % Compute the matrix exponential of A.
