% Macie Orrell
% Aerostat sizing tool
% =========================================================================

%% Initialization

close all
clear all
clf
clc

%% Create and plot different balloon shapes for desired size

% Run inputs file for spheroid plotting parameters
run('spheroidInitializationInputs.m'); 

% Create mesh
mesh.phi = linspace(0, 2*pi, 50); % Angle from +ve z-axis (azimuth)
mesh.theta = linspace(0, pi, 50); % Angle from +ve x-axis (polar)
[mesh.theta, mesh.phi] = meshgrid(mesh.theta, mesh.phi);

% Dynamic subplot tile layout
[cols, rows] = getSubplotGrid(length(spheroidInputs.slenderness_ratio));

figure(1); % Initialize figure
colormap turbo % Specify color map

for i = 1:1:length(spheroidInputs.slenderness_ratio)

    spheroidInputs.a = spheroidInputs.slenderness_ratio(i) * ...
    spheroidInputs.b;

    % Parametric equations for prolate spheroid
    plotSpheroid.x = spheroidInputs.b * sin(mesh.phi) .* cos(mesh.theta);
    plotSpheroid.y = spheroidInputs.b * sin(mesh.phi) .* sin(mesh.theta);
    plotSpheroid.z = spheroidInputs.a * cos(mesh.phi);

     % Get volume in m^3
    volume(i) = (4/3) * pi * spheroidInputs.a * spheroidInputs.b^2;
    
    % Get eccentricity of prolate shperoid
    e = sqrt((spheroidInputs.b^2-spheroidInputs.a^2) / spheroidInputs.b^2); 
        
    if e == 0
            % This is a sphere
            surface_area(i) = 4 * pi * spheroidInputs.b^2; 
            % Use formula for SA of a sphere
        
        else
            surface_area(i) = 2 * pi * spheroidInputs.b^2 * (1 + ...
                (spheroidInputs.a / (spheroidInputs.b * e)) * asin(e)); 
            % Use formula for SA of an ellipsoid
    end

    plotSpheroids(plotSpheroid.x, plotSpheroid.y, plotSpheroid.z, ...
        i, rows, cols, spheroidInputs.slenderness_ratio(i));
end

sgtitle('Prolate Spheroids with Different Slenderness Ratios');

%% Guess weight based on surface area material, tether weight and

library = createMaterialLibrary();

run('missionInputs.m') % Run inputs file for mission parameters

%% Input desired parameters


