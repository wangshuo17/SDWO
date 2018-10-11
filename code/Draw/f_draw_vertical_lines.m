function f_draw_vertical_lines( points, h1, h2, style, color )

n = size(points, 1);
for i=1:n
    
    pointA = [points(i, :) h1];
    pointB = [points(i, :) h2];
    
    f_drawline3(pointA, pointB, style, color);
    hold on;

end