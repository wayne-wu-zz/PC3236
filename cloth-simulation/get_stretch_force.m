function f = get_stretch_force( x, L )
%GET_STRETCH_FORCE Stretch Force

global Ks

abs_x = norm(x);

if abs_x < L
    f = [0,0,0]';
    return; 
end

f = Ks*(abs_x - L)*(x/abs_x);

end

