function a = crude(I, a, h)
% CRUDE: Brute force way of finding an 
% initial guess for the nonlinear curve fit

M = length(a);
for i = 1:M
    for k = 1:M
        if (k == i)
            a_plus(i) = a(i) + h;
            a_minus(i) = a(i) - h;
        else
            a_plus(k) = a(k);
            a_minus(k) = a(k);
        end
    end
    sp = sumsqerror(I, a_plus);
    s0 = sumsqerror(I, a);
    sm = sumsqerror(I, a_minus);
    
    a(i) = a(i) - 0.5*h*(sp-sm)/(sp-2*s0+sm);
    %h = 0.5*h;
end

