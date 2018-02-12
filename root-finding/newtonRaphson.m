function [ x ] = newtonRaphson( f, df, x )
%NEWTONRAPHSON Summary of this function goes here

TOL = 1e-6;
Error = 1e10;

while (Error > TOL)
    dx = f(x)/df(x);
    x = x - dx;
    Error = abs(dx/x);
end



