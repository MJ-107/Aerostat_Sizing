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
mesh.phi = linspace(0, 2*pi, 50); % Angle from +ve z-axis (polar)
mesh.theta = linspace(0, pi, 50); % Angle from +ve x-axis (azimuth)
[mesh.theta, mesh.phi] = meshgrid(mesh.theta, mesh.phi);

% Dynamic subplot tile layout
[cols, rows] = getSubplotGrid(length(spheroidInputs.slenderness_ratio));

figure(1); % Initialize figure
colormap turbo % Specify color map

for i = 1:1:length(spheroidInputs.slenderness_ratio)

    % c is major semi-axis (axis of symmetry, alinged w/ z)
    % a is minor semi-axis (equatorial plane, x/y constant)
    % a is constant specified in initialization script

    spheroidInputs.c = spheroidInputs.slenderness_ratio(i) * ...
    spheroidInputs.a; 

    % Parametric equations for prolate spheroid
    plotSpheroid.x = spheroidInputs.a * sin(mesh.phi) .* cos(mesh.theta);
    plotSpheroid.y = spheroidInputs.a * sin(mesh.phi) .* sin(mesh.theta);
    plotSpheroid.z = spheroidInputs.c * cos(mesh.phi);

     % Get volume in m^3
    volume(i) = (4/3) * pi * spheroidInputs.c * spheroidInputs.a^2;
    
    % Get eccentricity of prolate shperoid
    e = sqrt(1 - (spheroidInputs.a^2 / spheroidInputs.c^2));
        
    if e == 0
            % This is a sphere
            surface_area(i) = 4 * pi * spheroidInputs.a^2; 
            % Use formula for SA of a sphere
        
        else
            surface_area(i) = 2 * pi * spheroidInputs.a^2 * (1 + ...
                (spheroidInputs.c / (spheroidInputs.a * e)) * asin(e)); 
            % Use formula for SA of an ellipsoid
    end

    plotSpheroids(plotSpheroid.x, plotSpheroid.y, plotSpheroid.z, ...
        i, rows, cols, spheroidInputs.slenderness_ratio(i));
end

sgtitle('Prolate Spheroids with Different Slenderness Ratios');

%% Guess weight based on surface area material, tether weight and

library = createMaterialLibrary();

run('missionInputs.m') % Run inputs file for mission parameters

% % Lifting gas weight
% for i = 1:1:length(library.LiftingGas)
%     disp(1)
% end

% Preallocate arrays
% 4D matrix to store total weights
% Dimensions: (slenderness ratio, gas, envelope, tether)
total_weight = zeros(length(spheroidInputs.slenderness_ratio), ...
    numel(library.LiftingGas), numel(library.Envelope), ...
    numel(library.Tether));

%% 
for i = 1:1:length(spheroidInputs.slenderness_ratio)
    % --- Weight Calculations ---
    for g = 1:1:numel(library.LiftingGas)
        for e_idx = 1:1:numel(library.Envelope)
            for t = 1:1:numel(library.Tether)
                % Retrieve properties from the class objects
                rho_gas = library.LiftingGas(g).Density; % kg/m^3
                rho_env = library.Envelope(e_idx).WeightperMeter; % kg/m^2
                rho_tether = library.Tether(t).WeightperMeter; % kg/m^2 

                % Compute individual weights
                W_env = rho_env * surface_area(i);
                W_gas = rho_gas * volume(i);
                W_tether = rho_tether * surface_area(i); 
                % Total weight
                total_weight(i, g, e_idx, t) = W_env + W_gas + W_tether;
            end
        end
    end
end

%% Input desired parameters


