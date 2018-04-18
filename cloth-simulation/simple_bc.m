function bc = simple_bc( rows, cols )
%SIMPLE_BC Creates a simple points fixed boundary constraints

N = rows*cols;
bc = ones(3*N, 1);
idx = ptc_idx(1,1);
bc(idx:idx+2) = 0;
idx = ptc_idx(1,cols);
bc(idx:idx+2) = 0;
idx = ptc_idx(rows,cols);
bc(idx:idx+2) = 0;
idx = ptc_idx(rows,1);
bc(idx:idx+2) = 0;
idx = ptc_idx(int32(rows/2)+1, int32(cols/2)+1)
bc(idx:idx+2) = 0;

end

