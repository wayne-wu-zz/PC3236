function J = get_damping_jacobian( v_i, v_j )
%GET_DAMPING_FORCE get the jacobian for damping force

global Kd

J = Kd*eye(3);

end

