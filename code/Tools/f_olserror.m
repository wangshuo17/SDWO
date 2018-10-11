function [ e ] = f_olserror( a, b )

% x = linsolve(a, b);
x = pinv(a)*b;
diff = a*x-b;
e = norm(diff, 2);
e = e^2;

end