function f = q1_F( x )
% Q1: The integrand function as a function of x

global yy
global zz
y = yy;
z = zz;
f = sqrt(x.^3 + y.*x.^2 + z.^3)*exp(-x + y.^2 - z.^3);

end

