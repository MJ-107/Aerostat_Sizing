% Macie Orrell
% Aerostat sizing tool
% =========================================================================

%% Initialization

close all
clear all
clf
clc

%% Create + plot different balloon shapes for desired size

% == Run inputs file for spheroid plotting parameters ==
run('spheroidInitializationInputs.m'); 

% == Create mesh ==
mesh = computeMesh(spheroidInputs.phi_points, ...
    spheroidInputs.theta_points);

% == Create Plot ==
% Initialize plot tiles
[plotSpheroid.tile_cols, plotSpheroid.tile_rows] = ...
getSubplotGrid(length(spheroidInputs.slenderness_ratio));

figure(1); % Initialize figure
colormap turbo % Specify color map

% Loop through slenderness ratios and plot every spheroid
for r = 1:1:length(spheroidInputs.slenderness_ratio)
    spheroidInputs.c = spheroidInputs.slenderness_ratio(r) * ...
    spheroidInputs.a; 
    % Parametric equations for prolate spheroid
    plotSpheroid.x = spheroidInputs.a * sin(mesh.phi) .* cos(mesh.theta);
    plotSpheroid.y = spheroidInputs.a * sin(mesh.phi) .* sin(mesh.theta);
    plotSpheroid.z = spheroidInputs.c * cos(mesh.phi);
    % Use plotting function
    plotSpheroids(plotSpheroid.x, plotSpheroid.y, plotSpheroid.z, ...
     r, plotSpheroid.tile_rows, plotSpheroid.tile_cols, spheroidInputs.slenderness_ratio(r));
end

% Add plot title
sgtitle('Prolate Spheroids with Different Slenderness Ratios');

%% Calculate Volume and Surface Area

[volume, surface_area] = computeSAandV(spheroidInputs);

library = createMaterialLibrary();

run('missionInputs.m') % Run inputs file for mission parameters

% Preallocate arrays
total_weight = zeros(numel(library.Envelope), ...
    numel(library.Tether), numel(library.LiftingGas));

for r = 1:1:length(spheroidInputs.slenderness_ratio)
    
    spheroids(r) = spheroid(surface_area(r),volume(r),spheroidInputs.slenderness_ratio(r));
   
    % --- Weight Calculations ---
    for e = 1:1:numel(library.Envelope)
        for t = 1:1:numel(library.Tether)
            for g = 1:1:numel(library.LiftingGas)

                % Retrieve properties from the class objects
                rho_gas = library.LiftingGas(g).Density; % kg/m^3
                rho_tether = library.Tether(t).WeightperMeter; % kg/m^2
                rho_env = library.Envelope(e).WeightperMeter; % kg/m^2

                % Compute individual weights
                W_env = rho_env * surface_area(r);
                W_tether = rho_tether * surface_area(r); 
                W_gas = rho_gas * volume(r);
             
                % Total weight
                total_weight(e,t,g) = W_env +  W_tether + W_gas;
                
                spheroids(r).weight_envelope(e,t,g) = W_env;
                spheroids(r).weight_tether(e,t,g) = W_tether;
                spheroids(r).weight_gas(e,t,g) = W_gas;
            end
        end
    end

    spheroids(r).weight = total_weight;
    spheroids(r) = find_lowestWeight(spheroids(r));
end

minWeight = spheroids(1).lowest_total_weight;
for i = 2:1:length(spheroids)
   if spheroids(i).lowest_total_weight < minWeight
       minWeight = spheroids(i).lowest_total_weight;
       disp(i)
   end
end

%% Input desired parameters
