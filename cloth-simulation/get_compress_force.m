function f = get_compress_force( x, L )
%GET_COMPRESS_FORCE Compression Force

abs_x = norm(x);

% Compressive force is only applicable when Xij < L
if abs_x > L
    f = [0,0,0]';
    return;
end
    
f = fb(abs_x, L)*(x/abs_x);

end

