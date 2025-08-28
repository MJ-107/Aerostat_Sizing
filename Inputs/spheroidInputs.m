% spheroidInputs.m
% ----------------
% Inputs for spheroid plotting

% Slenderness ratio refers to the length/max diameter of the sheroid shape.
% a = semi-major axis (length) -> z-axis
% b = semi-minor axis (circular cross section diameter) -> x/y axis 
% Slenderness ratio (lambda) = L/dmax = 2b/2a
% A slenderness ratio of 1 refers to a perfect sphere.

slenderness_ratio = linspace(1, 6, 6);  % Slenderness ratio (lambda)
b = 1;                                  % Fixed semi-axis (x/y)
phi_points = 50;                        % Number of phi points (azimuth)
theta_points = 50;                      % Number of theta points (polar)