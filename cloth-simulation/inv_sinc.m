function x = inv_sinc( a )
%INV_SINC Approximation of Inverse Sinc Function 
%using Newton Raphson's Scheme

TOL = 1e-6;
e = 1e10;
i = 30; % Max Iteration

x = 3.14; % Initial Guess
while (e > TOL && i > 0)
    dx = (sin(x) - a*x)/(cos(x) - a);
    x = x - dx;
    e = abs(dx/x);
    i = i - 1;
end

end

