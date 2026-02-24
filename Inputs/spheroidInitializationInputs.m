% *** Inputs for spheroid plotting ***

% Slenderness ratio refers to the length/max diameter of the sheroid shape
% a = semi-major axis (length) -> z-axis
% b = semi-minor axis (circular cross section diameter) -> x/y axis 
% Slenderness ratio (lambda) = L/dmax = 2b/2a
% A slenderness ratio of 1 refers to a perfect sphere

spheroidInputs.slenderness_ratio = linspace(1, 6, 6); % Slenderness ratio (lambda)
spheroidInputs.dmax = 5;  % desired max diameter
spheroidInputs.phi_points = 50; % Number of phi points (azimuth)
spheroidInputs.theta_points = 50; % Number of theta points (polar)


% =====
spheroidInputs.a = spheroidInputs.dmax / 2; % Fixed semi-axis (x/y)
