function f_drawline3( a, b, style, color )
c = [a; b];
plot3(c(:, 1), c(:, 2), c(:, 3), style, 'linewidth',1, 'color', color);
end