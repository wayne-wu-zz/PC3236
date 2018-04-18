function bc = table_bc(rows, cols)
%TABLE_BC Creates the boundary condition for doing
%table cloth boundary constraints

N = rows*cols;
bc = ones(3*N,1);

I = int32(rows/2);
J = int32(cols/2);
i0 = I/2;
j0 = J/2;

% I = int32(rows/3);
% J = int32(cols/3);
% i0 = I;
% j0 = J;

for i = (i0+1):(i0+I)
    for j = (j0+1):(j0+J)
%         if (i == (i0+1) || i == (i0+I)) && (j == (j0+1) || j == (j0+J))
%             continue;
%         end
        idx = ptc_idx(i,j);
        bc(idx:idx+2) = 0;
    end
end

end

