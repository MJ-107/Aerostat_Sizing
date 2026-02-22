function [mesh] = computeMesh(phi_points, theta_points)

    % == Create 1D angular vectors ==
    % Angle from +ve z-axis (polar)
    phi   = linspace(0, pi, phi_points); % polar angle
    % Angle from +ve x-axis (azimuth)
    theta = linspace(0, 2*pi, theta_points); % azimuthal angle

    % == Create 2D grids ==
    [theta, phi] = meshgrid(theta, phi);

    % == Store in struct ==
    mesh.phi = phi;
    mesh.theta = theta;

end
