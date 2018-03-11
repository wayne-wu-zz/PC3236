function f = q1_I( z )
%Q1: Integrand of single integration as a function of z
global zz
zz = z;
f = glq(@q1_G, 0, z^2, 10);
end

