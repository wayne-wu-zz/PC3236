function root = bisection( f, left, right )

%f: the function to bisect
%left: the first point of the range
%right: the second point of the range

TOL=1e-4;
Error=1e10;
fLeft = f(left);
fRight = f(right);

while (Error>TOL)
    middle = (left+right)/2; fMiddle = f(middle);
    if (fLeft * fMiddle <= 0)
        right=middle; fRight=fMiddle;
    else
        left=middle; fLeft=fMiddle;
    end
    Error = abs((right-left)/middle);
end

root = middle;

