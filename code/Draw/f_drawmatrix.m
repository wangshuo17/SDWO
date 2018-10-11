function f_drawmatrix( position )
%F_DRAWMATRIX draw the points in the matrix in the 3-d space

if size(position, 2) == 3
    position = position';
end

if size(position, 1) ~= 3
    error('wrong data');
end

x = position(1,:);
y = position(2,:);
z = position(3,:);

N = 50;
[X, Y, Z] = griddata(x,y,z,linspace(min(x), max(x), N)', linspace(min(y),max(y), N), 'v4');

surf(X,Y,Z);
% pcolor(X,Y,Z);
% plot(z);
% pause(0.01);

end

