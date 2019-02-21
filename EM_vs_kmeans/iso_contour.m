function ellips = iso_contour(cov_matrix, centorids, sigma_factor)
    steps = 100;
    thetas = 0:(2*pi)/steps:2*pi;
    N = length(thetas);
    ellips = zeros(N, 2);

    [vect, vals] = eig(cov_matrix);

    % 3 * sigma => 99.7% of points inside iso-contour
    % 2 * sigma => 95.4% of points inside iso-contour
    % 1 * sigma => 68.2% of points inside iso-contour
    r1 = sqrt(vals(1, 1)) * sigma_factor;
    r2 = sqrt(vals(2, 2)) * sigma_factor;

    for i=1:N
        ellips(i, 1) = r1 * cos(thetas(i));
        ellips(i, 2) = r2 * sin(thetas(i));
    end

    ellips = ellips * vect;
    ellips = ellips + centorids;
end

