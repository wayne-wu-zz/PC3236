function [dfdx, dfdv] = get_jacobian( pos, vel )
%GET_POS_JACOBIAN get the Jacobians (dfdx, dfdv)
%pos: position vector
%vel: velocity vector

global N L rows cols type1 type2

dfdx = zeros(3*N, 3*N);
dfdv = zeros(3*N, 3*N);

for i = 1:rows
    for j = 1:cols
        i_idx = ptc_idx(i,j); 
        x0 = pos(i_idx:i_idx+2);
        v0 = vel(i_idx:i_idx+2);
        
        % Calculate change of force for particle i 
        % w.r.t change of position/velocity for particle j
        vJrow = zeros(3,3*N);
        xJrow = zeros(3,3*N);
        
        % Type 1 Jacobians
        for a = 1:length(type1)
            j_idx = ptc_idx(i+type1(a,1), j+type1(a,2));
            if j_idx > 0
                %Jij = numerical_jacobian(@get_stretch_force, pos(j_idx:j_idx+2)-x0, norm(type1(a,:))*L);
                Jij = get_stretch_jacobian(x0, pos(j_idx:j_idx+2),norm(type1(a,:))*L);
                xJrow(:,j_idx:j_idx+2) = xJrow(:,j_idx:j_idx+2) + Jij;
                xJrow(:,i_idx:i_idx+2) = xJrow(:,i_idx:i_idx+2) - Jij;
                %Jij = numerical_jacobian(@get_damping_force, v0-vel(j_idx:j_idx+2));
                Jij = get_damping_jacobian();
                vJrow(:,j_idx:j_idx+2) = vJrow(:,j_idx:j_idx+2) + Jij;
                vJrow(:,i_idx:i_idx+2) = vJrow(:,i_idx:i_idx+2) - Jij;
            end 
        end 
        
        % Type 2 Jacobians
        for a = 1:length(type2)
            j_idx = ptc_idx(i+type2(a,1), j+type2(a,2));
            if j_idx > 0
                %Jij = numerical_jacobian(@get_compress_force, pos(j_idx:j_idx+2)-x0, norm(type2(a,:))*L);
                Jij = get_compress_jacobian(x0, pos(j_idx:j_idx+2),norm(type2(a,:))*L);
                xJrow(:,j_idx:j_idx+2) = xJrow(:,j_idx:j_idx+2) + Jij;
                xJrow(:,i_idx:i_idx+2) = xJrow(:,i_idx:i_idx+2) - Jij;
                %Jij = numerical_jacobian(@get_damping_force, v0-vel(j_idx:j_idx+2));
                Jij = get_damping_jacobian();
                vJrow(:,j_idx:j_idx+2) = vJrow(:,j_idx:j_idx+2) + Jij;
                vJrow(:,i_idx:i_idx+2) = vJrow(:,i_idx:i_idx+2) - Jij;
            end
        end
        
        dfdx(i_idx:i_idx+2, :) = xJrow;
        dfdv(i_idx:i_idx+2, :) = vJrow;
    end 
end

end

