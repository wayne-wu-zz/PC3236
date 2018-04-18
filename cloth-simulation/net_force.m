function f = net_force( pos, vel )
%NET_FORCE calculates the net force vector

global L N g rows cols M type1 type2

f = zeros(3*N, 1);

% Add External Forces
% f(idx:idx+2) = f(idx:idx+2) + M*[0,0,-9.81]'; % Gravity
% TODO: Drag Force

% Add Internal Forces
for i = 1:rows
    for j = 1:cols
  
        % Calculate net force (external + internal)    
        idx = ptc_idx(i, j);
        
        % External Force
        f(idx:idx+2) = f(idx:idx+2) + M(idx,idx)*g*[0,0,-1]';
        
        % Calculate internal forces due to neighbouring particles (j)
        x = pos(idx:idx+2);
        v = vel(idx:idx+2);
        
        % Type 1 Forces
        for a = 1:length(type1)
            j_idx = ptc_idx(i+type1(a,1), j+type1(a,2));
            if j_idx > 0
                f(idx:idx+2) = f(idx:idx+2) + get_stretch_force(pos(j_idx:j_idx+2) - x, norm(type1(a,:))*L) + get_damping_force(v - vel(j_idx:j_idx+2));
            end
        end 
        
        % Type 2 Forces
        for a = 1:length(type2) 
            j_idx = ptc_idx(i+type2(a,1), j+type2(a,2));
            if j_idx > 0
                f(idx:idx+2) = f(idx:idx+2) + get_compress_force(pos(j_idx:j_idx+2) - x, norm(type2(a,:))*L) + get_damping_force(v - vel(j_idx:j_idx+2));
            end
        end 
 
    end 
end 

end

