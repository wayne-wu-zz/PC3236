function J = numerical_jacobian( func, x0, varargin )
%NUMERICAL_JACOBIAN Calculates the Jacobian element 
%using finite difference

f = feval(func, x0, varargin{:});
n = length(f);
m = length(x0);
J = zeros(n,m);

% Central Difference
dev = diag(1e-3*ones(size(x0)));
for i = 1:m
    ff = feval(func, x0+dev(:,i), varargin{:});
    fb = feval(func, x0-dev(:,i), varargin{:});
    J(:,i) = (ff-fb)/(2*dev(i,i));
end

