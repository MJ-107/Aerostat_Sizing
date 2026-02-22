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

[volume, surface_area] = ComputeSAandV(spheroidInputs);

% Dynamic subplot tile layout
[cols, rows] = getSubplotGrid(length(spheroidInputs.slenderness_ratio));

figure(1); % Initialize figure
colormap turbo % Specify color map

for r=1:1:length(spheroidInputs.slenderness_ratio)
    spheroidInputs.c = spheroidInputs.slenderness_ratio(r) * ...
    spheroidInputs.a; 
        % Parametric equations for prolate spheroid
    plotSpheroid.x = spheroidInputs.a * sin(mesh.phi) .* cos(mesh.theta);
    plotSpheroid.y = spheroidInputs.a * sin(mesh.phi) .* sin(mesh.theta);
    plotSpheroid.z = spheroidInputs.c * cos(mesh.phi);

     plotSpheroids(plotSpheroid.x, plotSpheroid.y, plotSpheroid.z, ...
     r, rows, cols, spheroidInputs.slenderness_ratio(r));
end
sgtitle('Prolate Spheroids with Different Slenderness Ratios');

%% Guess weight based on surface area material, tether weight and

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



% semiRigid = input(['Is the aerostat rigid, semi-rigid, or non-rigid?' ...
%     ' input case 1, 2, or 3, respectively ']);
% 
% switch semiRigid
%     case 1
%         disp('Rigid aerostat');
%         %add weight params for case
% 
%     case 2
%         disp('Semi-Rigid aerostat');
%         %add weight params for case
% 
%     case 3
%         disp('Non-Rigid aerostat');
%         %add weight params for case
% 
%     otherwise
%         disp('Invalid input. Please enter true or false.');
% end



