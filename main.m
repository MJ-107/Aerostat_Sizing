% Macie Orrell
% Aerostat sizing tool
% =========================================================================

%% Initialization

close all
clear all
clf
clc

%% Create and plot different balloon shapes for desired size

run('spheroidInputs.m'); % Run inputs file for spheroid plotting parameters

% Create mesh
phi = linspace(0, 2*pi, 50); % Angle from +ve z-axis (azimuth)
theta = linspace(0, pi, 50); % Angle from +ve x-axis (polar)
[theta, phi] = meshgrid(theta, phi);

% Dynamic subplot tile layout
[cols, rows] = getSubplotGrid(length(slenderness_ratio));

figure(1); % Initialize figure
colormap turbo

for i = 1:1:length(slenderness_ratio)

    a = slenderness_ratio(i) * b;

    % Parametric equations for prolate spheroid
    x = b * sin(phi) .* cos(theta);
    y = b * sin(phi) .* sin(theta);
    z = a * cos(phi);

    volume(i) = (4/3) * pi * a * b^2; % Get volume in m^3
    e = sqrt(1 - (b^2 / a^2)); 
    
        if e == 0
            % This is a sphere
            surface_area(i) = 4 * pi * b^2;
        else
            surface_area(i) = 2 * pi * b^2 * (1 + (a / (b * e)) * asin(e));
        end

    plotSpheroids(x, y, z, i, rows, cols, slenderness_ratio(i));
end

sgtitle('Prolate Spheroids with Different Slenderness Ratios');

%% Input desired parameters

% inputs.payloadWeight = 5; % in kgs
% inputs.tetherWeight = 0.1; % in kgs/m
% inputs.Alt = 500; % in ms
% 
% tetherWeight = inputs.tetherWeight * inputs.Alt; % in kgs



















%%




% Axis def 
% a = length along z
% b = length along x
% c = length along y 
% 
% % Guess length and Dmax
% length = ;
% b = length /2;
% a = 
% c = D_max;
% %d_factor = linspace(); % se as a bunch of fracs
% d_factor = 1;
% D_max = 1ength * d_factor % set D_max initial to length (sphere case first)
% 
% Create Prolate Spheroid Profile
% 
% % Input radii
% a = 1;  % distance from center to equator (short axis) z,y
% c = 2;  % distance from center to pole (long axis) x,y
% 
% [theta, phi] = meshgrid(linspace(0, pi, 50), linspace(0, 2*pi, 100));
% 
% % Parametric surface of a prolate spheroid
% x = a * sin(theta) .* cos(phi);  % short radius
% y = a * sin(theta) .* sin(phi);  % short radius
% z = c * cos(theta);              
% 
% % Plot: swap axes so Z becomes horizontal (X), X becomes vertical (Y), Y becomes depth (Z)
% figure
% surf(z, x, y)  % Swapping variables here
% axis equal
% xlabel('Z (former long axis)')
% ylabel('X (former equator)')
% zlabel('Y (former equator)')
% title('Prolate Spheroid with Z Axis Along X (Hot Dog View)')
% shading interp
% colormap turbo
% light
% lighting gouraud

%% ====
% % Parameters
% a = 1;
% length_factors = [1.2, 1.5, 2, 3];
% num = length(length_factors);
% 
% [theta, phi] = meshgrid(linspace(0, pi, 50), linspace(0, 2*pi, 100));
% 
% figure
% hold on
% 
% for i = 1:num
%     c = length_factors(i);
% 
%     % Parametric surface
%     x = a * sin(theta) .* cos(phi);
%     y = a * sin(theta) .* sin(phi);
%     z = c * cos(theta);
% 
%     % Shift each spheroid along Y so they don't overlap
%     y_shift = (i - (num+1)/2) * (2.5 * a);  % Spread out in Y axis
% 
%     % Reorient Z → X
%     surf(z, x, y + y_shift)  % Swap and shift
% end
% 
% axis equal
% xlabel('Z (long axis → X)')
% ylabel('X (short axis → Y)')
% zlabel('Y (short axis → Z)')
% title('Prolate Spheroids with Varying Lengths (Z → X)')
% shading interp
% colormap turbo
% lighting gouraud
% light
% view(3)


%% Calculate Lifting Gas required in liquid and gas phases


