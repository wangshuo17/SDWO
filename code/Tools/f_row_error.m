function [ errormsg ] = f_row_error( turevalue, predictvalue )
%F_RMSE calculate the error between two vectors

error = zeros(6, size(turevalue, 2));

error(1, :) = turevalue;
error(2, :) = predictvalue;
error(3, :) = abs(error(1, :) - error(2, :));
error(4, :) = error(3, :).^2;
error(5, :) = mean(error(4, :));
error(6, :) = sqrt(error(5, :));

errormsg.rmse = error(6, 1);
errormsg.mean = mean(error(3, :));
errormsg.max = max(error(3, :));
errormsg.detail = error;

end