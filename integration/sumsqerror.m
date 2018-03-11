function f = sumsqerror( func, params )
%SUMSQERROR Summary of this function goes here
%   Detailed explanation goes here
global W_data I_data

I = func(W_data, params(1), params(2));
b = (I_data-I).^2;
f = sum(b);

end

