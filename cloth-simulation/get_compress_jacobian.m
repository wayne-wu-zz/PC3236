function J = get_compress_jacobian( p_i, p_j, L )
%GET_COMPRESS_FORCE Compression Force

J = zeros(3);
x = p_j - p_i;
abs_x = norm(x);

% Compressive force should only be applied when Xij < L? 
if abs_x > L
    return;
end

fb_x = fb(abs_x, L);

% Approximate dfb/dx using backward difference
dfbdx = (fb_x - fb(abs_x - 0.0001, L))/0.0001; 

% Vector derivative
xx = (x*x')/(x'*x);

% Jacobian
J = dfbdx*xx + (fb_x/abs_x)*(eye(3) - xx);

end

