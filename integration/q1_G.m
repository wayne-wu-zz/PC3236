function f = q1_G( y )
%Q1: integrand of double integral as a function of y
global yy
yy = y;
% zz = z;
f = glq(@q1_F, 0, sqrt(1-y), 10);
end

