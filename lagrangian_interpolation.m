function y_interp = lagrangian_interpolation(x, y, x_interp)
    % Lagrangian interpolation
    % Inputs:
    %   x: x-coordinates of the data points
    %   y: y-coordinates of the data points
    %   x_interp: x-coordinates at which to interpolate
    % Output:
    %   y_interp: Interpolated y-coordinates at x_interp

    n = length(x);          % Number of data points
    m = length(x_interp);   % Number of points to interpolate
    
    y_interp = zeros(1, m);  % interpolated y-coordinates
    
    % Compute interpolation at each x_interp point
    
    for j = 1:m
        % Compute Lagrange basis polynomials
        L = ones(1, n);
        for i = 1:n
            for k = 1:n
                if k ~= i
                    L(i) = L(i) * (x_interp(j) - x(k)) / (x(i) - x(k));
                end
            end
        end
        
        % Compute interpolated y-coordinate
        y_interp(j) = sum(y .* L);
    end
end

