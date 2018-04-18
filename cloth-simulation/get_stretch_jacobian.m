function J = get_stretch_jacobian( p_i, p_j, L )
%GET_STRETCH_FORCE Stretch Force

global Ks

J = zeros(3);

x = p_j - p_i;
abs_x = norm(x);

if abs_x < L
    return; 
end

xx = x*x'/(x'*x);

J = Ks*xx + Ks*(1 - L/abs_x)*(eye(3) - xx);

end



