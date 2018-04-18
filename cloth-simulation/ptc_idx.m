function idx = ptc_idx( i, j )
%PTC_IDX get the particle index based on grid indices i, j

global rows cols

if i <= 0 || j <= 0 || i > rows || j > cols
    idx = -1;
    return;
end 

n = (i-1)*rows+j;  % Particle Number
idx = (n-1)*3 + 1; % Particle index number

end

